#!/bin/bash

# Gemini CLI Installer Script for Debian/Ubuntu
set -e

echo "📦 Updating system packages..."
sudo apt update

echo "📥 Installing Node.js and npm..."
sudo apt install -y nodejs npm

echo "🧠 Installing Gemini CLI via npm..."
sudo npm install -g @google/gemini-cli

echo "🔑 Please enter your Gemini API Key:"
read -rp "API Key: " api_key

echo "💾 Saving API key to shell config..."
shell_config="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ]; then
  shell_config="$HOME/.zshrc"
fi

# Avoid duplicate lines
grep -q GEMINI_API_KEY "$shell_config" || echo "export GEMINI_API_KEY=\"$api_key\"" >> "$shell_config"

# Load into current session
export GEMINI_API_KEY="$api_key"

echo "✅ Installation complete!"
echo "Try running: gemini chat \"Hello, Gemini!\""

