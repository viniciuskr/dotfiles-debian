#!/bin/bash

# Script para instalar Visual Studio Code via Snap

set -e

echo "Verificando se o Snap está instalado..."

if ! command -v snap &> /dev/null; then
  echo "Snap não encontrado. Instalando snapd..."
  sudo apt update
  sudo apt install -y snapd
  sudo systemctl enable --now snapd.socket
fi

echo "Instalando Visual Studio Code (VS Code) via Snap..."
sudo snap install code --classic

echo "VS Code instalado com sucesso!"

