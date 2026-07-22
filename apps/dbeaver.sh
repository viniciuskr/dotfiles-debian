#!/bin/bash
set -e

echo "=== Instalando DBeaver Community Edition (dbeaver-ce) ==="

# Atualiza pacotes
sudo apt update -y

# Instala dependências
sudo apt install -y wget gpg apt-transport-https ca-certificates

# Importa a chave GPG do repositório
wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/dbeaver.gpg

# Adiciona o repositório oficial
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list

# Atualiza a lista de pacotes e instala o DBeaver CE
sudo apt update -y
sudo apt install -y dbeaver-ce

echo "=== Instalação concluída! Você pode abrir o DBeaver com o comando: dbeaver ==="