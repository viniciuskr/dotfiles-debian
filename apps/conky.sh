#!/bin/bash

# Script to install and configure Conky on Debian/Ubuntu
set -e

echo "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing Conky..."
sudo apt install conky-all -y

echo "📁 Creating config directory..."
mkdir -p ~/.config/conky

echo "📝 Writing default Conky configuration..."
cat << 'EOF' > ~/.config/conky/conky.conf
conky.config = {
    alignment = 'top_right',
    background = true,
    update_interval = 1,
    double_buffer = true,
    minimum_width = 200,
    maximum_width = 300,
    own_window = true,
    own_window_type = 'desktop',
    own_window_transparent = true,
    font = 'DejaVu Sans Mono:size=10',
    default_color = 'white',
};

conky.text = [[
${time %A, %d %B %Y}
${time %H:%M:%S}
CPU: ${cpu}%
RAM: ${mem}/${memmax}
Disk: ${fs_used /}/${fs_size /}
]];
EOF

echo "🚀 Starting Conky..."
conky -c ~/.config/conky/conky.conf &

echo "✅ Conky installed and running!"

