FROM ubuntu:24.04

# Arguments
# Note: These can be overriden by invoking docker like so:
# > docker build --build-arg LEAN_MLIR_COMMIT=abcdef .
ARG LEAN_MLIR_COMMIT=28b780232c1e7c47c0360cff34e7ef50955ded21

# Set up non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Create a new user named 'user' with no password and switch to it
# Needed to install opam packages while avoiding sandboxing issues
RUN useradd -m -s /bin/bash user && \
    adduser user sudo && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER user

# Download and unzip SMT-LIB QF_BV benchmarks
# WARNING: This is a large file, so downloading may take a while,
#          which is why we put it so high in the Dockerfile (to maximize caching)
RUN mkdir -p bv-evaluation/SMT-LIB && \
    curl -L  https://zenodo.org/records/15493090/files/QF_BV.tar.zst?download=1 | \
    tar --extract --zstd --file - -C bv-evaluation/SMT-LIB 

# install dependencies
RUN apt-get update && \
    apt-get install --yes \
        tzdata \
        pip \
        python3-venv \
        build-essential \
        cmake \
        git \
        ninja-build \
        ripgrep \ 
        gdb curl wget zstd unzip sudo \
        # dependencies for experiment scripts
        python3-matplotlib python3-pandas python3-num2words python3-tabulate \
        # bitwuzla dependencies
        meson libgmp-dev libcadical-dev libsymfpu-dev pkg-config \
        # CoqQFBV dependencies
        libboost-timer-dev && \
    apt-get clean

# HACK around Lean-MLIR self-reference incompatibility with docker cache:
# Do all the work in the home directory for now and move it to the lean-mlir directory later
RUN mkdir -p /home/user/lean-mlir
WORKDIR /home/user/lean-mlir

# Install elan and update environment
RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none
ENV PATH=/home/user/.elan/bin:$PATH

# Install bv-theorem-table-maker

RUN git clone https://github.com/opencompl/bv-theorem-table-maker.git && cd bv-theorem-table-maker && git checkout 4a3b029fbcea100f54d79261ed6ed1e6e8b8bc2d 

# Create Solvers directory
RUN mkdir -p bv-evaluation/solvers

# Install Bitwuzla (commit: 22.6.25)
RUN cd bv-evaluation/solvers && git clone https://github.com/bitwuzla/bitwuzla && cd bitwuzla && git checkout 0dca38d0f62fa9002ad6278ca6374838a69ade19
RUN cd bv-evaluation/solvers/bitwuzla && ./configure.py && cd build && ninja && sudo ninja install

# Install CoqQFBV (commit: 09.04.23)
RUN cd bv-evaluation/solvers && git clone https://github.com/fmlab-iis/coq-qfbv && cd coq-qfbv && git checkout bb055f7b05dd81a5ddf89c734bde140a9feecf70
WORKDIR bv-evaluation/solvers/coq-qfbv
RUN yes "/usr/local/bin" | bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)" && \
    opam init --disable-sandboxing --bare
RUN opam switch create ocaml-base-compiler.4.14.0
RUN eval $(opam env) && \
    opam repo add coq-released https://coq.inria.fr/opam/released && \
    opam pin --yes coq 8.15.2 && \
    opam pin --yes coq-mathcomp-ssreflect 1.14.0 && \
    opam install --yes coq-mathcomp-algebra
RUN git submodule init && \
    git submodule update && \
    eval $(opam env) && \
    make -C lib/coq-nbits && \
    make -C lib/coq-ssrlib && \
    make
RUN cd src/ocaml && eval $(opam env) && dune build
RUN mkdir bin
RUN cp src/ocaml/_build/default/coqQFBV.exe bin/coqQFBV.exe
# Install Kissat (version: 4.0.1)
RUN cd bin && \
    curl -L -o kissat-4.0.1-linux-amd64.zip https://github.com/arminbiere/kissat/releases/download/rel-4.0.1/kissat-4.0.1-linux-amd64.zip && \
    unzip -j kissat-4.0.1-linux-amd64.zip && \
    mv kissat-4.0.1-linux-amd64 kissat && \
    rm kissat-4.0.1-linux-amd64.zip
# Install GRATgen (version: 1.3.2)
RUN cd lib && \
    curl -L -o gratgen.tgz https://www21.in.tum.de/~lammich/grat/archive/v1.3.2/gratgen.tgz && \
    tar -xzf gratgen.tgz && \
    rm gratgen.tgz && \
    cd gratgen && \
    sed -i '16a add_definitions(-DBOOST_TIMER_ENABLE_DEPRECATED)' CMakeLists.txt && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make && \
    cp gratgen ../../../bin
# Install MLton (version: 30.12.24)
RUN cd lib && ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        curl -L -o mlton.tgz https://github.com/MLton/mlton/releases/download/on-20241230-release/mlton-20241230-1.amd64-linux.ubuntu-24.04_static.tgz ; \
        tar -xzf mlton.tgz ; \
        mv mlton-20241230-1.amd64-linux.ubuntu-24.04_static mlton ; \
    elif [ "$ARCH" = "aarch64" ]; then \
        curl -L -o mlton.tgz https://github.com/MLton/mlton/releases/download/on-20241230-release/mlton-20241230-1.arm64-linux.ubuntu-24.04-arm_static.tgz ; \
        tar -xzf mlton.tgz ; \
        mv mlton-20241230-1.arm64-linux.ubuntu-24.04-arm_static mlton ; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1 ; \
    fi && \
    rm mlton.tgz
# Install GRATchk (version: 1.3.2)
RUN cd lib && \
    curl -L -o gratchk-sml.tgz https://www21.in.tum.de/~lammich/grat/archive/v1.3.2/gratchk-sml.tgz && \
    tar -xzf gratchk-sml.tgz && \
    rm gratchk-sml.tgz && \
    cd gratchk-sml && \
    PATH=/home/user/lean-mlir/bv-evaluation/solvers/coq-qfbv/lib/mlton/bin:$PATH make && \
    cp gratchk ../../bin
WORKDIR /home/user/lean-mlir

# Install Leanwuzla (commit: 30.06.25)
# This is a fork of Leanwuzla with modifications to support the evaluation
RUN cd bv-evaluation/solvers && git clone https://github.com/abdoo8080/Leanwuzla && \
    cd Leanwuzla && git checkout 1c8543dfcb325dd113527ddd55ab9c1190c5a111 && \
    lake build

# Install Lean-MLIR (tag: oopsla25-bv-decide)
# Note: copying contents of lean-mlir-temp to lean-mlir is much faster than doing the opposite
RUN echo "v7"
RUN cd .. && git clone https://github.com/opencompl/lean-mlir lean-mlir-temp && \
    cd lean-mlir-temp && git checkout $LEAN_MLIR_COMMIT  \
    cd .. && cp -r lean-mlir-temp/. lean-mlir && \
    rm -rf lean-mlir-temp

# Install Python dependencies
RUN python3 -m venv .venv && \
    .venv/bin/pip install -r requirements.txt

# Setup Python env
ENV VIRTUAL_ENV=/home/user/lean-mlir/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

USER user
