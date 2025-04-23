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


# net tools
apt install -y telnet dnsutils iputils-ping

# 
apt install -y build-essential pkg-config libssl-dev libcurl4-openssl-dev

# 
cd /tmp 

# tiny go
TINYGO_VERSION=0.37.0
wget https://github.com/tinygo-org/tinygo/releases/download/v${TINYGO_VERSION}/tinygo_${TINYGO_VERSION}_amd64.deb
sudo dpkg -i tinygo_${TINYGO_VERSION}_amd64.deb

# hugo
HUGO_VERSION=0.146.7
wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb
dpkg -i hugo_extended_${HUGO_VERSION}_linux-amd64.deb

rm -rf /tmp/*.deb

# auto remove
echo "clear apt"
apt autoremove 
apt clean 
apt autoclean 
rm -rf /var/cache/apt/* 

# user ssh dir
mkdir /home/vscode/.ssh 
chmod -R 0777 /home/vscode/.ssh 
chown -R vscode:vscode /home/vscode/.ssh

echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf