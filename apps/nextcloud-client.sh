#!/bin/bash

# Script para instalar o cliente oficial do Nextcloud no Ubuntu/Debian

set -e

echo "Adicionando repositório oficial do Nextcloud Desktop Client..."
sudo add-apt-repository -y ppa:nextcloud-devs/client

echo "Atualizando pacotes..."
sudo apt update

echo "Instalando o cliente do Nextcloud..."
sudo apt install -y nextcloud-desktop

echo "Cliente Nextcloud instalado com sucesso!"

