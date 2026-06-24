#!/bin/bash

if [ "${GOPROXY}" != "" ]; then go env -w GOPROXY=${GOPROXY} ; fi

echo "install go tools vscode required"
go install github.com/ramya-rao-a/go-outline@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
go install github.com/haya14busa/goplay/cmd/goplay@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install golang.org/x/tools/gopls@latest

# 

# Determine which version script to source based on VARIANT
VERSION_SCRIPT="${VARIANT}.sh"

if [ -f "$(dirname "$0")/sh_go/$VERSION_SCRIPT" ]; then
    echo "Running version specific script: $VERSION_SCRIPT"
    bash "$(dirname "$0")/sh_go/$VERSION_SCRIPT"
else
    echo "Warning: No version specific config found for VARIANT=$VARIANT (expected scripts/sh_go/$VERSION_SCRIPT)"
    # Fallback to a default if necessary or just continue
fi

echo "echo general tools"
go install github.com/lopygo/about/cmd/aboutbuilder@latest
go install golang.org/x/tools/cmd/stringer@latest
go install github.com/spf13/cobra-cli@latest


echo "other tools"
wget -O /usr/local/bin/fetch https://github.com/gruntwork-io/fetch/releases/download/v0.4.4/fetch_linux_amd64
upx -9 /usr/local/bin/fetch
chmod +x /usr/local/bin/fetch

echo "clean go src"
cd $GOPATH
chown -R vscode .
cd -
