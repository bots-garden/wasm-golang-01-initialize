FROM gitpod/workspace-full
USER gitpod

# ------------------------------------
# Install Go
# ------------------------------------
RUN <<EOF
GO_VERSION="1.21.1"

GOPATH=$HOME/go-packages
GOROOT=$HOME/go
PATH=$GOROOT/bin:$GOPATH/bin:$PATH

curl -fsSL https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | tar xzs \
    && printf "%s\n" "export GOPATH=/workspace/go" \
                     "export PATH=$GOPATH/bin:$PATH" > $HOME/.bashrc.d/300-go
go version
go install -v golang.org/x/tools/gopls@latest
go install -v github.com/ramya-rao-a/go-outline@latest
go install -v github.com/stamblerre/gocode@v1.0.0

EOF

# ------------------------------------
# Install TinyGo
# ------------------------------------
RUN <<EOF
TINYGO_VERSION="0.30.0"

wget https://github.com/tinygo-org/tinygo/releases/download/v${TINYGO_VERSION}/tinygo_${TINYGO_VERSION}_amd64.deb
sudo dpkg -i tinygo_${TINYGO_VERSION}_amd64.deb
rm tinygo_${TINYGO_VERSION}_amd64.deb

EOF

# ------------------------------------
# Install Wasm runtimes
# ------------------------------------
RUN <<EOF
curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | bash
curl https://wasmtime.dev/install.sh -sSf | bash

EOF
