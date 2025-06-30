#!/bin/bash

# Script para instalar GNOME Tweaks, Extensões do GNOME e suporte a extensões via navegador

echo "Atualizando a lista de pacotes..."
sudo apt update

echo "Instalando o GNOME Tweaks..."
sudo apt install -y gnome-tweaks

echo "Instalando pacotes de extensões do GNOME..."
sudo apt install -y gnome-shell-extensions

echo "Instalando suporte para extensões via navegador..."
sudo apt install -y chrome-gnome-shell

echo "Instalação concluída!"

# Informações adicionais
echo ""
echo "Agora você pode:"
echo "- Abrir o GNOME Tweaks com o comando: gnome-tweaks"
echo "- Gerenciar extensões em: https://extensions.gnome.org"
echo ""

# Opcional: abrir GNOME Tweaks agora
read -p "Deseja abrir o GNOME Tweaks agora? (s/n): " abrir
if [[ "$abrir" =~ ^[sS]$ ]]; then
  gnome-tweaks &
fi

