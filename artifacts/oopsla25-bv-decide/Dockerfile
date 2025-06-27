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
        gdb curl wget zstd unzip sudo \
        # dependencies for experiment scripts
        python3-matplotlib python3-pandas python3-num2words \
        # bitwuzla dependencies
        meson libgmp-dev libcadical-dev libsymfpu-dev pkg-config \
        # CoqQFBV dependencies
        libboost-timer-dev mlton && \
    apt-get clean

# Create a new user named 'user' with no password and switch to it
# Needed to install opam packages while avoiding sandboxing issues
RUN useradd -m -s /bin/bash user && \
    adduser user sudo && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN mkdir -p /code && chown user:user /code # Create /code as root before switching

USER user

# Install elan and update environment
RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none
ENV PATH=/home/user/.elan/bin:$PATH


# Install Bitwuzla (commit: 22.6.25)
RUN cd /home/user && git clone https://github.com/bitwuzla/bitwuzla
# && git checkout 0dca38d0f62fa9002ad6278ca6374838a69ade19
WORKDIR /home/user/bitwuzla
RUN ./configure.py && cd build && ninja && sudo ninja install

RUN echo "v2"
RUN cd /code && git clone https://github.com/opencompl/lean-mlir && cd lean-mlir
WORKDIR /code/lean-mlir

# Ensure the .lake/packages directory is clean before running lake update
RUN rm -rf .lake/packages/mathlib && lake update && lake build

# Install dependencies
RUN python3 -m venv .venv && \
    .venv/bin/pip install -r requirements.txt

# Setup python env
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"

USER root