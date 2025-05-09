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

echo "install go grpc cli"
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

echo "echo general tools"
go install github.com/lopygo/about/cmd/aboutbuilder@latest

go install golang.org/x/tools/cmd/stringer@latest

go install github.com/spf13/cobra-cli@latest

# 
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.64.7
golangci-lint --version

# go get github.com/go-bindata/go-bindata/...
# go get github.com/elazarl/go-bindata-assetfs/...

echo "other tools"
wget -O /usr/local/bin/fetch https://github.com/gruntwork-io/fetch/releases/download/v0.4.4/fetch_linux_amd64
upx -9 /usr/local/bin/fetch
chmod +x /usr/local/bin/fetch


echo "clean go src"
cd $GOPATH
#  why ???
# rm -rf src pkg
chown -R vscode .
cd -