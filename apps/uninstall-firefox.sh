#!/bin/bash

# Script para desinstalar o Firefox no Ubuntu (Snap e APT)

set -e

echo "Verificando se o Firefox está instalado via Snap..."
if snap list | grep -q firefox; then
  echo "Removendo Firefox (Snap)..."
  sudo snap remove firefox
else
  echo "Firefox (Snap) não encontrado."
fi

echo "Verificando se o Firefox está instalado via APT..."
if dpkg -l | grep -q firefox; then
  echo "Removendo Firefox (APT)..."
  sudo apt purge -y firefox
  sudo apt autoremove -y
else
  echo "Firefox (APT) não encontrado."
fi

echo "Firefox foi desinstalado com sucesso (se estava presente)."

