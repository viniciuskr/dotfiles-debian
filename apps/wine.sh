#!/bin/bash

set -e

echo "🧪 Adicionando suporte à arquitetura i386..."
sudo dpkg --add-architecture i386

echo "🔄 Atualizando repositórios..."
sudo apt update

echo "🍷 Instalando Wine com suporte 32 bits..."
sudo apt install -y wine wine32 wine64 libwine libwine:i386 fonts-wine

echo "✅ Verificando versão do Wine instalada:"
wine --version

echo "🚀 Rodando winecfg para configuração inicial..."
winecfg

echo "✅ Instalação concluída com sucesso!"

