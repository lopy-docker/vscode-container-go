# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.195.0/containers/go/.devcontainer/base.Dockerfile
# [Choice] Go version (use -bullseye variants on local arm64/Apple Silicon): 1, 1.16, 1.17, 1-bullseye, 1.16-bullseye, 1.17-bullseye, 1-buster, 1.16-buster, 1.17-buster
# [Choice] Go version (use -bullseye variants on local arm64/Apple Silicon): 1, 1.16, 1.17, 1-bullseye, 1.16-bullseye, 1.17-bullseye, 1-buster, 1.16-buster, 1.17-buster
ARG VARIANT=1
ARG DEBIAN_VERSION=bookworm
# ARG DEBIAN_VERSION=bullseye
FROM mcr.microsoft.com/vscode/devcontainers/go:1-${VARIANT}-${DEBIAN_VERSION}

# [Choice] Node.js version: lts/*, 16, 14, 12, 10
ARG NODE_VERSION="lts/*"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c ". /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

ADD sh_go.sh /tmp/sh_go.sh
ADD sh_npm.sh /tmp/sh_npm.sh
ADD sh_sys.sh /tmp/sh_sys.sh
ADD sh_tool.sh /tmp/sh_tool.sh



RUN chmod +x /tmp/sh_sys.sh && /tmp/sh_sys.sh


ARG GOPROXY=""
RUN chmod +x /tmp/sh_go.sh && /tmp/sh_go.sh

# [Optional] Uncomment this line to install global node packages.
# RUN  su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g commitizen cz-conventional-changelog" 2>&1
RUN chmod +x /tmp/sh_npm.sh && su vscode -c "/tmp/sh_npm.sh" 2>&1

RUN chmod +x /tmp/sh_tool.sh && /tmp/sh_tool.sh

# deletes the script
# RUN echo "install proxychain4" \
#   && git clone --depth=1 https://github.com/uljjmhn520/proxychains \
#   && cd "proxychains" \
#   && ./configure && make && make install \
#   && cd ".." \
#   && rm -rf "proxychains" \
#   && ldconfig \
#   && echo "SOCKS5 proxy host ip and port in environment variable 'PROXYCHAINS_SOCKS5_HOST' and 'PROXYCHAINS_SOCKS5_PORT'"
  
# ENV PROXYCHAINS_SOCKS5_HOST=127.0.0.1 \
#   PROXYCHAINS_SOCKS5_PORT=1080

RUN su vscode -c "mkdir /home/vscode/.cache -p"