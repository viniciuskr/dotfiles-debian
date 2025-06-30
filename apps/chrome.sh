#!/bin/bash

# Script para instalar Google Chrome no Ubuntu/Debian

set -e

echo "Baixando o pacote .deb do Google Chrome..."
wget -O google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

echo "Instalando o pacote .deb..."
sudo apt install -y ./google-chrome.deb

echo "Removendo o instalador..."
rm google-chrome.deb

echo "Google Chrome instalado com sucesso!"

