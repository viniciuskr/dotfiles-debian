#!/usr/bin/env bash
# Instala o Solaar (gerenciador de dispositivos Logitech) no Debian
# Uso: sudo ./instalar-solaar.sh [--no-autostart]
set -euo pipefail

# --------- opções ----------
AUTOSTART=1
if [[ "${1:-}" == "--no-autostart" ]]; then AUTOSTART=0; fi

# --------- checagens ----------
if [[ $EUID -ne 0 ]]; then
  echo "Por favor, rode como root (ex.: sudo $0)"; exit 1
fi

if ! command -v apt >/dev/null 2>&1; then
  echo "Este script exige apt (Debian/Ubuntu)."; exit 1
fi

# --------- detectar versão ----------
. /etc/os-release
echo "Detectado: $PRETTY_NAME"

# --------- atualizar e instalar ----------
echo "Atualizando índices do APT..."
apt-get update -y

echo "Instalando pacotes: solaar + dependências úteis..."
apt-get install -y --no-install-recommends \
  solaar \
  usbutils \
  python3-gi gir1.2-gtk-3.0

# --------- pós-instalação ----------
# Udev rules do pacote já costumam cobrir os receptores Logitech.
# Recarrega regras por garantia (não é estritamente necessário).
if command -v udevadm >/dev/null 2>&1; then
  echo "Recarregando regras do udev..."
  udevadm control --reload-rules || true
  udevadm trigger || true
fi

# --------- autostart opcional ----------
if [[ "$AUTOSTART" -eq 1 ]]; then
  echo "Configurando Solaar para iniciar com a sessão do usuário padrão..."

  # tenta descobrir o usuário logado mais recente no tty/sudo
  TARGET_USER="${SUDO_USER:-$(logname 2>/dev/null || echo "")}"
  if [[ -z "$TARGET_USER" || "$TARGET_USER" == "root" ]]; then
    echo "Não consegui identificar um usuário não-root para o autostart."
    echo "Você pode criar manualmente em: ~/.config/autostart/solaar.desktop"
  else
    USER_HOME="$(eval echo "~$TARGET_USER")"
    AUTOSTART_DIR="$USER_HOME/.config/autostart"
    mkdir -p "$AUTOSTART_DIR"

    cat > "$AUTOSTART_DIR/solaar.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Solaar
Comment=Inicia o gerenciador de dispositivos Logitech
# Tenta ocultar a janela; se falhar, abre normal
Exec=sh -c 'solaar -w hide || solaar'
X-GNOME-Autostart-enabled=true
Terminal=false
Categories=Utility;
EOF

    chown -R "$TARGET_USER":"$TARGET_USER" "$AUTOSTART_DIR"
    echo "Autostart criado em: $AUTOSTART_DIR/solaar.desktop"
  fi
else
  echo "Autostart desabilitado por --no-autostart."
fi

# --------- final ----------
echo
echo "✅ Solaar instalado."
echo "• Para abrir agora, execute: solaar &"
echo "• Caso não apareça no menu, relogue ou rode: setsid solaar &>/dev/null &"
echo "• Para desinstalar: sudo apt-get remove -y solaar"