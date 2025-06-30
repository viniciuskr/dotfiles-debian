#!/bin/bash

# Script para instalar GNOME Tweaks, Extensões do GNOME, suporte via navegador e Extension Manager (mjakeman)

set -e

echo "Atualizando lista de pacotes..."
sudo apt update

echo "Instalando GNOME Tweaks..."
sudo apt install -y gnome-tweaks

echo "Instalando pacotes de extensões do GNOME..."
sudo apt install -y gnome-shell-extensions

echo "Instalando suporte para extensões via navegador..."
sudo apt install -y chrome-gnome-shell

echo "Instalando dependências para Extension Manager..."
sudo apt install -y curl gpg

echo "Instalando Extension Manager..."
sudo apt install -y gnome-extension-manager

echo "Instalação concluída com sucesso!"
echo ""
echo "Você agora pode:"
echo "- Abrir GNOME Tweaks com: gnome-tweaks"
echo "- Gerenciar extensões com o aplicativo: Extension Manager"
echo "- Acessar também: https://extensions.gnome.org"
echo ""

read -p "Deseja abrir o GNOME Tweaks agora? (s/n): " abrir
if [[ "$abrir" =~ ^[sS]$ ]]; then
  gnome-tweaks &
fi

