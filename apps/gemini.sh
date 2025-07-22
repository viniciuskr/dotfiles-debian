#!/bin/bash

echo "🔄 Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "📦 Instalando dependências essenciais..."
sudo apt install -y curl gnupg ca-certificates build-essential

echo "🌐 Adicionando repositório oficial do Node.js 20.x..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

echo "🟢 Instalando Node.js e npm..."
sudo apt install -y nodejs

echo "🔧 Verificando versão do Node.js e npm..."
node -v
npm -v

echo "💬 Instalando Gemini CLI globalmente via npm..."
sudo npm install -g @google/gemini-cli

echo "✅ Verificando instalação do Gemini..."
gemini --version

echo -e "\n✅ Instalação concluída com sucesso!"
echo "🔑 Para usar o Gemini CLI, você pode:"
echo "   - Autenticar via Google Account (ao executar: gemini)"
echo "   - OU definir uma variável de ambiente com sua API Key:"
echo "     export GEMINI_API_KEY='SUA_API_KEY_AQUI'"
