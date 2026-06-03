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

# Detect Go version to install compatible tools
GO_VERSION_FULL=$(go version | awk '{print $3}' | sed 's/go//')
GO_VERSION_MAJOR=$(echo $GO_VERSION_FULL | cut -d. -f1)
GO_VERSION_MINOR=$(echo $GO_VERSION_FULL | cut -d. -f2)

# Default versions (latest)
PROTOC_GEN_GO_VERSION="latest"
PROTOC_GEN_GO_GRPC_VERSION="latest"
GOLANGCI_LINT_VERSION="v1.64.7"

# Pin versions for compatibility with older Go versions
if [ "$GO_VERSION_MAJOR" -eq 1 ]; then
    if [ "$GO_VERSION_MINOR" -le 20 ]; then
        PROTOC_GEN_GO_VERSION="v1.33.0"
        PROTOC_GEN_GO_GRPC_VERSION="v1.3.0"
        GOLANGCI_LINT_VERSION="v1.53.3"
    elif [ "$GO_VERSION_MINOR" -le 22 ]; then
        # v1.34.0+ requires Go 1.21+
        # v1.60.0+ for golangci-lint requires Go 1.22+
        PROTOC_GEN_GO_VERSION="v1.34.2"
        PROTOC_GEN_GO_GRPC_VERSION="v1.5.1"
        if [ "$GO_VERSION_MINOR" -eq 21 ]; then
            GOLANGCI_LINT_VERSION="v1.55.2"
        else
            GOLANGCI_LINT_VERSION="v1.60.2"
        fi
    fi
fi

echo "Detected Go $GO_VERSION_FULL: using protoc-gen-go@$PROTOC_GEN_GO_VERSION, protoc-gen-go-grpc@$PROTOC_GEN_GO_GRPC_VERSION, golangci-lint@$GOLANGCI_LINT_VERSION"

echo "install go grpc cli"
go install google.golang.org/protobuf/cmd/protoc-gen-go@${PROTOC_GEN_GO_VERSION}
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@${PROTOC_GEN_GO_GRPC_VERSION}

echo "echo general tools"
go install github.com/lopygo/about/cmd/aboutbuilder@latest

go install golang.org/x/tools/cmd/stringer@latest

go install github.com/spf13/cobra-cli@latest

# 
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(go env GOPATH)/bin ${GOLANGCI_LINT_VERSION}
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