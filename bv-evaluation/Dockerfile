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
        ninja-build \
        gdb curl wget \
        # dependencies for experiment scripts
        python3-matplotlib python3-pandas python3-num2words

# Install Lean
RUN curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf > /code/elan.sh \
    && sh /code/elan.sh -y # elan
ENV PATH /root/.elan/bin:$PATH
ENV LIBRARY_PATH /root/.elan/lib:$LIBRARY_PATH

# Install Bitwuzla
RUN git clone https://github.com/bitwuzla/bitwuzla
WORKDIR /code/bitwuzla
RUN ./configure.py && build && ninja install

# First, get cached dependencies
WORKDIR /code/lean-mlir
COPY lean-toolchain lakefile.toml lake-manifest.json ./
RUN lake exe cache get!

# Then, copy & build lean-mlir
COPY . .

RUN lake build

# Set the evaluation script directory as working dir
WORKDIR /code/lean-mlir/bv-evaluation
# Set python as entrypoint, since the experiments are python scripts
ENTRYPOINT [ "python3" ]

USER root

