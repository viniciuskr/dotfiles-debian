#!/bin/bash

set -e

echo "==> Atualizando pacotes..."
if command -v apt >/dev/null 2>&1; then
    sudo apt update -y
    echo "==> Instalando Python, pip e venv (Debian/Ubuntu)..."
    sudo apt install -y python3 python3-pip python3-venv
elif command -v dnf >/dev/null 2>&1; then
    echo "==> Instalando Python, pip e venv (Fedora/RedHat)..."
    sudo dnf install -y python3 python3-pip python3-virtualenv
elif command -v yum >/dev/null 2>&1; then
    echo "==> Instalando Python, pip e venv (CentOS/RedHat)..."
    sudo yum install -y python3 python3-pip python3-virtualenv
else
    echo "Gerenciador de pacotes não suportado. Instale manualmente."
    exit 1
fi

echo "==> Verificando versões instaladas..."
python3 --version
pip3 --version

echo "==> Instalação concluída!"
