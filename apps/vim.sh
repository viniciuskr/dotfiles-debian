#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print messages
echo_info() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

echo_error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo_error "Please run as root (use sudo)"
    exit 1
fi

echo_info "Updating package list..."
apt update -y

echo_info "Installing Vim..."
apt install -y vim

echo_info "Vim has been installed successfully!"
