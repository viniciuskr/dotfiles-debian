#!/bin/bash

# Script para instalar VLC Media Player via Snap

set -e

echo "Verificando se o Snap está instalado..."

if ! command -v snap &> /dev/null; then
  echo "Snap não encontrado. Instalando snapd..."
  sudo apt update
  sudo apt install -y snapd
  sudo systemctl enable --now snapd.socket
fi

echo "Instalando VLC via Snap..."
sudo snap install vlc

echo "VLC instalado com sucesso!"
