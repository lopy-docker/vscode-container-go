#!/bin/bash
apt update 
apt install -y upx g++-mingw-w64-x86-64 g++-mingw-w64-i686 \
    bash-completion \
    protobuf-compiler \
    clang-format

# 
apt install -y build-essential pkg-config libssl-dev libcurl4-openssl-dev

# auto remove
echo "clear apt"
apt autoremove 
apt clean 
apt autoclean 
rm -rf /var/cache/apt/* 