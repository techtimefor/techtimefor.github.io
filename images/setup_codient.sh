#!/bin/bash

# Codient Termux Setup Script

# Show Codient logo
display_logo() {
    echo ""
    echo -e "\e[32m" 
    echo "                 ╔═══════════════╗"
    echo "                 ║               ║"
    echo "                 ║   ┌─────┐    ║"
    echo "                 ║   │ </> │    ║"
    echo "                 ║   └─────┘    ║"
    echo "                 ║               ║"
    echo "                 ╚═══════════════╝"
    echo ""
    echo "              █▀▀ █▀█ █▀▄ █ █▀▀ █▄░█ ▀█▀"
    echo "              █▄▄ █▄█ █▄▀ █ ██▄ █░▀█ ░█░"
    echo -e "\e[0m"  
    echo ""
}

display_logo

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if a package is installed
package_installed() {
    pkg list-installed | grep -q "^$1"
}

echo "📱 Setting up your Termux environment..."
echo ""

# Step 1: Setup storage
echo "🗄️  Setting up storage access..."
if [ -d ~/storage ]; then
    echo "✅ Storage already set up."
else
    echo "⏳ Running termux-setup-storage..."
    termux-setup-storage
    echo "✅ Storage access configured."
fi
echo ""

# Step 2: Update and upgrade packages
echo "📦 Checking for package updates..."
echo "⏳ Running pkg update && pkg upgrade..."
pkg update && pkg upgrade -y
echo "✅ Packages updated and upgraded."
echo ""

# Step 3: Install OpenSSH
echo "🔒 Setting up SSH..."
if package_installed "openssh"; then
    echo "✅ OpenSSH is already installed."
else
    echo "⏳ Installing OpenSSH..."
    pkg install openssh -y
    echo "✅ OpenSSH installed."
fi
echo ""

# Step 3: Install OpenSSH
echo "🔒 Setting up SSH..."
if package_installed "openssh"; then
    echo "✅ OpenSSH is already installed."
else
    echo "⏳ Installing OpenSSH..."
    pkg install openssh -y
    echo "✅ OpenSSH installed."
fi
echo ""

# Step 4: Install iproute2
echo "🔒 Setting up SSH..."
if package_installed "openssh"; then
    echo "✅ OpenSSH is already installed."
else
    echo "⏳ Installing iproute2..."
    pkg install iproute2 -y
    echo "✅ iproute2 installed."
fi
echo ""

# Step 5: Start SSH server
echo "🔌 Starting SSH server..."
if pgrep sshd >/dev/null; then
    echo "✅ SSH server is already running."
else
    echo "⏳ Starting sshd..."
    sshd
    echo "✅ SSH server started."
fi
echo ""

# Step 6: Set up wake lock
echo "⏰ Setting up wake lock..."
if command_exists termux-wake-lock; then
    echo "⏳ Activating wake lock..."
    termux-wake-lock
    echo "✅ Wake lock activated."
else
    echo "❌ termux-wake-lock command not found. Make sure Termux:API is installed."
    echo "⏳ Installing Termux:API package..."
    pkg install termux-api -y
    echo "✅ Now try running this script again."
fi
echo ""

# Step 7: Set password
echo "🔑 Setting up password..."
echo "⏳ You will be prompted to enter a new password."
echo "ℹ️  If you already have a password set, you'll need to enter it first."
passwd
echo "✅ Password has been set."
echo ""

#Step 8: Show Username
echo "👤 Showing username..."
echo "Your username is: $(whoami)"
echo ""

# Step 9: Detect and display IP address
echo "🌐 Detecting network interfaces..."
echo "Your IP addresses:"
ip_address=$(ip addr show | grep -E "inet .* wlan" | grep -v inet6 | grep -oE "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | cut -d' ' -f2)
if [ -n "$ip_address" ]; then
    echo "✅ Local WiFi IP address: $ip_address"
else
    echo "❌ No WiFi IP address detected."
    echo "Other interfaces:"
    ip addr | grep -E "inet " | grep -v 127.0.0.1 | grep -oE "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | cut -d' ' -f2 | while read -r line; do
        echo "  • $line"
    done
fi
echo ""

# Final message
echo "🎉 Setup complete! Your Termux environment is ready to use."
echo ""
echo "Thank you for using the Codient Termux Setup Script."
echo "⚠️  Please keep Termux running and return to Codient now, you will be asked for your username and password on Codient."
echo "" 
