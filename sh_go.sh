#!/bin/bash

if [ "${GOPROXY}" != "" ]; then go env -w GOPROXY=${GOPROXY} ; fi

echo "install go tools"
go install github.com/ramya-rao-a/go-outline@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
go install github.com/haya14busa/goplay/cmd/goplay@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install golang.org/x/tools/gopls@latest

echo "echo general tools"
go install github.com/lopygo/about/cmd/aboutbuilder@latest

go install golang.org/x/tools/cmd/stringer@latest
go get github.com/go-bindata/go-bindata/...
go get github.com/elazarl/go-bindata-assetfs/...

echo "other tools"
wget -O /usr/local/bin/fetch https://github.com/gruntwork-io/fetch/releases/download/v0.4.4/fetch_linux_amd64
chmod +x /usr/local/bin/fetch

cd $GOPATH
rm -rf pkg src
chown -R vscode .
cd -