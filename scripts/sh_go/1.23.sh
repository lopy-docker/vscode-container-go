#!/bin/bash

echo "install go grpc cli for 1.23"
go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.12
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.5.1
go install golang.org/x/tools/cmd/stringer@v0.34.0

echo "install golangci-lint v1.64.7"
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.64.7
