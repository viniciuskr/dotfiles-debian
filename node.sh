#!/bin/bash

echo "🔄 Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "📦 Instalando dependências..."
sudo apt install -y curl gnupg ca-certificates build-essential

echo "🌐 Adicionando repositório oficial do Node.js 20.x..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

echo "🟢 Instalando Node.js..."
sudo apt install -y nodejs

echo "✅ Versões instaladas:"
node -v
npm -v

echo "✅ Node.js e npm instalados com sucesso!"
#
