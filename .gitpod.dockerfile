FROM gitpod/workspace-full
USER gitpod

# ------------------------------------
# Install Go
# ------------------------------------

#ENV GO_VERSION="1.21.1"

#ENV GOPATH=$HOME/go-packages
#ENV GOROOT=$HOME/go
#ENV PATH=$GOROOT/bin:$GOPATH/bin:$PATH


ENV <<EOF
GO_VERSION="1.21.1"

GOPATH=$HOME/go-packages
GOROOT=$HOME/go
PATH=$GOROOT/bin:$GOPATH/bin:$PATH

EOF

RUN <<EOF
curl -fsSL https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | tar xzs \
    && printf "%s\n" "export GOPATH=/workspace/go" \
                     "export PATH=$GOPATH/bin:$PATH" > $HOME/.bashrc.d/300-go
go version
go install -v golang.org/x/tools/gopls@latest
go install -v github.com/ramya-rao-a/go-outline@latest
go install -v github.com/stamblerre/gocode@v1.0.0

EOF

#RUN curl -fsSL https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | tar xzs \
#    && printf '%s\n' 'export GOPATH=/workspace/go' \
#                      'export PATH=$GOPATH/bin:$PATH' > $HOME/.bashrc.d/300-go

#RUN go version
#RUN go install -v golang.org/x/tools/gopls@latest
#RUN go install -v github.com/ramya-rao-a/go-outline@latest
#RUN go install -v github.com/stamblerre/gocode@v1.0.0

# ------------------------------------
# Install TinyGo
# ------------------------------------
ARG TINYGO_VERSION="0.30.0"

RUN <<EOF
wget https://github.com/tinygo-org/tinygo/releases/download/v${TINYGO_VERSION}/tinygo_${TINYGO_VERSION}_amd64.deb
sudo dpkg -i tinygo_${TINYGO_VERSION}_amd64.deb
rm tinygo_${TINYGO_VERSION}_amd64.deb

EOF

#RUN wget https://github.com/tinygo-org/tinygo/releases/download/v${TINYGO_VERSION}/tinygo_${TINYGO_VERSION}_amd64.deb
#RUN sudo dpkg -i tinygo_${TINYGO_VERSION}_amd64.deb
#RUN rm tinygo_${TINYGO_VERSION}_amd64.deb

# ------------------------------------
# Install Wasm runtimes
# ------------------------------------
RUN <<EOF
curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | bash
curl https://wasmtime.dev/install.sh -sSf | bash

EOF

#RUN curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | bash
#RUN curl https://wasmtime.dev/install.sh -sSf | bash
