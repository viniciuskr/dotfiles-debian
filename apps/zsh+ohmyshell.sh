#!/bin/bash

# Instalação completa do Zsh + Oh My Zsh + Tema Agnoster
set -e

echo "🔧 Instalando Zsh..."
sudo apt update
sudo apt install -y zsh git curl wget fonts-powerline

echo "✅ Zsh instalado: $(zsh --version)"

echo "🎨 Instalando Oh My Zsh..."
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "🛠 Alterando shell padrão para Zsh..."
chsh -s $(which zsh)

echo "🎨 Configurando tema 'agnoster'..."
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' "$ZSHRC"
else
    echo 'export ZSH_THEME="agnoster"' >> "$ZSHRC"
fi

echo "🔁 Aplicando configurações..."
source "$ZSHRC"

echo "✅ Tudo pronto! Reinicie o terminal ou faça logout/login para usar o Zsh com Oh My Zsh."

