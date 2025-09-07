#!/bin/bash

echo "🕹️ Instalador do Steam para Debian/Ubuntu iniciado..."

# Atualiza os pacotes
sudo apt update && sudo apt upgrade -y

# Habilita suporte a 32 bits
echo "🔧 Ativando arquitetura i386..."
sudo dpkg --add-architecture i386
sudo apt update

# Instala dependências
echo "📦 Instalando dependências necessárias..."
sudo apt install -y \
  libgl1-mesa-dri:i386 \
    libgl1-mesa-glx:i386 \
      libc6:i386 \
        libx11-6:i386 \
          software-properties-common \
            apt-transport-https 
 	      ca-certificates \
                curl \
                  wget \
                    gnupg

                    # Instala o Steam
                    echo "🚀 Instalando o Steam..."
                    sudo apt install -y steam

                    # Finalização
                    echo "✅ Steam instalado! Você pode iniciar com o comando: steam"
                    echo "🎮 Lembre-se de ativar o Steam Play (Proton) nas configurações do cliente Steam."
