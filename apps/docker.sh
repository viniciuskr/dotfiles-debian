#!/usr/bin/env bash
set -euo pipefail

# =========================
# Docker Engine + Compose
# Ubuntu 22.04/24.04 e Debian 12+
# =========================

# ---- Helpers
retry() {
  local n=0
  local max=${2:-5}
  local delay=${3:-3}
  until [ $n -ge $max ]; do
    eval "$1" && break
    n=$((n+1))
    echo "Tentativa $n falhou. Retentando em ${delay}s..."
    sleep "$delay"
  done
  [ $n -lt $max ] || { echo "Comando falhou após ${max} tentativas: $1"; exit 1; }
}

ensure_https_sources() {
  # Força HTTPS nos sources principais (Ubuntu/Debian)
  if [ -f /etc/apt/sources.list ]; then
    sudo sed -i 's|http://security.ubuntu.com|https://security.ubuntu.com|g' /etc/apt/sources.list || true
    sudo sed -i 's|http://archive.ubuntu.com|https://br.archive.ubuntu.com|g' /etc/apt/sources.list || true
    sudo sed -i 's|http://deb.debian.org|https://deb.debian.org|g' /etc/apt/sources.list || true
    sudo sed -i 's|http://ftp.[a-zA-Z0-9.-]*/debian|https://deb.debian.org/debian|g' /etc/apt/sources.list || true
  fi
}

add_docker_repo() {
  local id_like="$1"   # ubuntu/debian
  local codename="$2"  # noble, jammy, bookworm...

  echo "=== Adicionando repositório oficial do Docker (${id_like}) ==="
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL "https://download.docker.com/linux/${id_like}/gpg" | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  local arch="$(dpkg --print-architecture)"
  local source_line="deb [arch=${arch} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/${id_like} ${codename} stable"
  echo "$source_line" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
}

# ---- Detecta distro
if [ -r /etc/os-release ]; then
  . /etc/os-release
else
  echo "Não foi possível detectar a distribuição."
  exit 1
fi

ID_LIKE="${ID_LIKE:-$ID}" # às vezes ID_LIKE vem mais informativo
CODENAME="${VERSION_CODENAME:-$(lsb_release -cs 2>/dev/null || echo '')}"

if [[ "$ID" != "ubuntu" && "$ID" != "debian" && "$ID_LIKE" != *"ubuntu"* && "$ID_LIKE" != *"debian"* ]]; then
  echo "Este script foi feito para Ubuntu/Debian. Detectado: ID=$ID ID_LIKE=$ID_LIKE"
  exit 1
fi

if [ -z "$CODENAME" ]; then
  echo "Não consegui identificar o codename da distro."
  exit 1
fi

echo "Detectado: ID=$ID (like: $ID_LIKE), codename=$CODENAME"

# ---- Limpa leftovers e prepara ambiente
echo "=== Preparando ambiente APT ==="
ensure_https_sources

echo "=== Limpando caches/listas APT ==="
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

echo "=== Atualizando índices (com retries) ==="
retry "sudo apt-get update -o Acquire::Retries=5 -o Acquire::http::Timeout=30" 5 4

echo "=== Removendo Docker antigo (se houver) ==="
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

echo "=== Instalando dependências ==="
retry "sudo apt-get install -y ca-certificates curl gnupg lsb-release --fix-missing" 5 4

# ---- Adiciona repositório do Docker
if [[ "$ID" == "ubuntu" || "$ID_LIKE" == *"ubuntu"* ]]; then
  add_docker_repo "ubuntu" "$CODENAME"
else
  add_docker_repo "debian" "$CODENAME"
fi

echo "=== Atualizando índices (com retries) ==="
retry "sudo apt-get update -o Acquire::Retries=5 -o Acquire::http::Timeout=30" 5 4

# ---- Instala Docker Engine + Buildx + Compose (plugin)
echo "=== Instalando Docker Engine, Buildx e Compose (plugin) ==="
retry "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin --fix-missing" 5 4

# ---- Habilita/Start
echo '=== Habilitando e iniciando serviço docker ==='
sudo systemctl enable docker
sudo systemctl start docker || true

# ---- Grupo docker
echo "=== Adicionando usuário '$USER' ao grupo docker ==="
if getent group docker >/dev/null 2>&1; then
  sudo usermod -aG docker "$USER"
else
  sudo groupadd docker || true
  sudo usermod -aG docker "$USER"
fi

# ---- Sanity check
echo "=== Verificando versões ==="
docker --version || echo "docker não no PATH ainda (precisa relogar)."
docker compose version || echo "docker compose plugin não disponível no PATH ainda."

echo "=== Pronto! ==="
echo "» Saia e entre novamente na sessão, ou rode:  newgrp docker"
echo "» Teste:  docker run --rm hello-world"
