# Main Lean image
FROM ubuntu:24.04
WORKDIR /code

# Install dependencies
RUN apt-get update -y \
    && DEBIAN_FRONTEND="noninteractive" apt-get install --yes \
        tzdata \
        build-essential \
        cmake \
        git \
        ripgrep \
        vim \
        neovim \
        emacs \
        ninja-build \
        gdb curl wget

# Install Lean
RUN curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf > /code/elan.sh \
    && sh /code/elan.sh -y # elan
ENV PATH /root/.elan/bin:$PATH
ENV LIBRARY_PATH /root/.elan/lib:$LIBRARY_PATH

# Download & build lean-mlir
RUN curl -L https://github.com/opencompl/ssa/archive/refs/tags/v0.1.3.tar.gz > /code/ssa.tar.gz # SSA tar file
RUN tar xf ssa.tar.gz && ls /code/ && mv ssa-0.1.3 ssa # untar
WORKDIR /code/ssa
RUN lake -R exe cache get
RUN lake build SSA mlirnatural

USER root
