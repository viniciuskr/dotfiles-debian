#!/bin/bash
# Script para instalar o Kitty via APT e defini-lo como terminal padrão

set -e

echo "=== Atualizando lista de pacotes ==="
sudo apt update -y

echo "=== Instalando Kitty ==="
sudo apt install -y kitty

echo "=== Adicionando Kitty ao update-alternatives ==="
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 50

echo "=== Definindo Kitty como terminal padrão ==="
sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty

echo "=== Instalação concluída! ==="
echo "Kitty foi instalado e agora é o terminal padrão."
echo "Para testar, rode: kitty"
