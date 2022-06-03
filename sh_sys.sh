#!/bin/bash
apt update 
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

apt-get update

apt install -y upx g++-mingw-w64-x86-64 g++-mingw-w64-i686 \
    bash-completion \
    protobuf-compiler \
    docker-ce-cli \
    clang-format

# 
apt install -y build-essential pkg-config libssl-dev libcurl4-openssl-dev

# auto remove
echo "clear apt"
apt autoremove 
apt clean 
apt autoclean 
rm -rf /var/cache/apt/* 