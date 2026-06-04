#!/bin/bash
PROTOC_GEN_GO_VERSION="v1.33.0"
PROTOC_GEN_GO_GRPC_VERSION="v1.3.0"
GOLANGCI_LINT_VERSION="v1.53.3"

echo "install go grpc cli for 1.20"
go install google.golang.org/protobuf/cmd/protoc-gen-go@${PROTOC_GEN_GO_VERSION}
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@${PROTOC_GEN_GO_GRPC_VERSION}

echo "install golangci-lint ${GOLANGCI_LINT_VERSION}"
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(go env GOPATH)/bin ${GOLANGCI_LINT_VERSION}
