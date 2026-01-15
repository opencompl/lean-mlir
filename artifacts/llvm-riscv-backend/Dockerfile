FROM ubuntu:24.04

# Set up non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

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

# Create a new user named 'user' with no password and switch to it
# Needed to install opam packages while avoiding sandboxing issues
RUN useradd -m -s /bin/bash user && \
    adduser user sudo && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER user

# HACK around Lean-MLIR self-reference incompatibility with docker cache:
# Do all the work in the home directory for now and move it to the lean-mlir directory later
RUN mkdir -p /home/user/lean-mlir
WORKDIR /home/user/lean-mlir

# Install elan and update environment
RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none
ENV PATH=/home/user/.elan/bin:$PATH

# Install LLVM 
RUN curl -fLo llvm.sh https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 18 && \
    apt-get install -y clang-18 lldb-18 lld-18 clangd-18 && \
    rm llvm.sh

ENV PATH="/usr/lib/llvm-18/bin:$PATH"

# Install MLIR-fuzz

# Install Lean-MLIR (tag: oopsla25-bv-decide)
# Note: copying contents of lean-mlir-temp to lean-mlir is much faster than doing the opposite
RUN cd .. && git clone https://github.com/opencompl/lean-mlir lean-mlir-temp && \
    cd lean-mlir-temp && git checkout a6adafb20f1246a0f28a2ac81af8caefa606531f && \
    cd .. && cp -r lean-mlir-temp/. lean-mlir && \
    rm -rf lean-mlir-temp
RUN MATHLIB_NO_CACHE_ON_UPDATE=1 LAKE_NO_CACHE=1 lake update --no-cache

# Setup Python env
ENV VIRTUAL_ENV=/home/user/lean-mlir/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

USER user
