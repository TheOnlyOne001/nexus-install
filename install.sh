
# Update System
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install git curl pkg-config libssl-dev protobuf-compiler -y

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# Add Rust target
rustup target add riscv32i-unknown-none-elf


# Set OpenSSL Environment Variables
echo 'export OPENSSL_DIR=/usr' >> ~/.bashrc
echo 'export OPENSSL_LIB_DIR=/usr/lib/x86_64-linux-gnu' >> ~/.bashrc
echo 'export OPENSSL_INCLUDE_DIR=/usr/include/openssl' >> ~/.bashrc
echo 'export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig' >> ~/.bashrc
source ~/.bashrc

# Confirm installation
cargo --version
protoc --version
nexus --version

# Memmory Dag
curl -O https://gist.githubusercontent.com/NodeFarmer/013a495f61761903b1378a64cbe64810/raw/2524770f735e2c292d30e02c11f5447b052f63ad/nexus_swap.sh && chmod +x nexus_swap.sh && ./nexus_swap.sh

# Install Nexus CLI
curl https://cli.nexus.xyz/ | sh

echo "Installation completed!"
