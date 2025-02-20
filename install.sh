#!/bin/bash

# Update System
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y git curl pkg-config libssl-dev protobuf-compiler screen

# Start a new screen session and run the installation inside it
screen -dmS nexus_install bash -c '
    # Install Rust
    curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"

    # Add Rust target
    rustup target add riscv32i-unknown-none-elf

    # Set OpenSSL Environment Variables
    echo "export OPENSSL_DIR=/usr" >> ~/.bashrc
    echo "export OPENSSL_LIB_DIR=/usr/lib/x86_64-linux-gnu" >> ~/.bashrc
    echo "export OPENSSL_INCLUDE_DIR=/usr/include/openssl" >> ~/.bashrc
    echo "export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig" >> ~/.bashrc
    source ~/.bashrc

    # Confirm installation
    cargo --version
    protoc --version
    nexus --version

    # Memory DAG
    curl -O https://gist.githubusercontent.com/NodeFarmer/013a495f61761903b1378

    # Install Nexus CLI
    curl https://cli.nexus.xyz/ | sh

    # Start Nexus CLI and automatically enter options
    echo -e "1\n6684878" | nexus
'

echo "Nexus installation and execution are running in a screen session."
echo "To check progress, run: screen -r nexus_install"
