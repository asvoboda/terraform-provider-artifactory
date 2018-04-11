GOFMT_FILES?=$$(find . -name '*.go' | grep -v vendor)
PROJDIR := $(realpath $(CURDIR))
SOURCEDIR := $(PROJDIR)/
BUILDDIR := $(PROJDIR)/dist

all: test build

install-hooks:
	@misc/scripts/install-hooks

dep:
	@misc/scripts/deps-ensure
	@dep ensure -v

fmt:
	@gofmt -w $(GOFMT_FILES)

test:
	@go test -v ./...
	@go vet ./...

build:
	@mkdir -pv $(BUILDDIR)
	@go build -o $(BUILDDIR)/terraform-provider-artifactory ./cmd/provider/main.go

install:
	@misc/scripts/install-provider

.PHONY: clean build
clean:
	-@rm -rf ./dist/
