#!/bin/bash
apt update 
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common -y


# install docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update

apt install -y docker-ce-cli docker-buildx-plugin docker-compose-plugin

# gcc...
apt install -y g++-mingw-w64-x86-64 g++-mingw-w64-i686 \
    bash-completion \
    protobuf-compiler \
    clang-format

# install upx
UPX_VERSION=4.2.4
wget https://github.com/upx/upx/releases/download/v${UPX_VERSION}/upx-${UPX_VERSION}-amd64_linux.tar.xz
tar -xvf upx-${UPX_VERSION}-amd64_linux.tar.xz
mv upx-${UPX_VERSION}-amd64_linux/upx /usr/local/bin
chmod +x /usr/local/bin/upx
rm -rf upx-${UPX_VERSION}-amd64_linux*


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