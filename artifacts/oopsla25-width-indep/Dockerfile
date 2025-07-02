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
        gdb curl wget \
        timg

ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

# Install Lean
RUN curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf > /code/elan.sh \
    && sh /code/elan.sh -y # elan
ENV PATH /root/.elan/bin:$PATH
ENV LIBRARY_PATH /root/.elan/lib:$LIBRARY_PATH

# Download & build lean-mlir
RUN echo "v5"
RUN git clone  https://github.com/opencompl/lean-mlir.git 
WORKDIR /code/lean-mlir
RUN git checkout bf3ecb44670f69fe255e06761e9374f22039b086
RUN lake -R exe cache get
RUN lake build

# setup python env
RUN uv venv /opt/venv
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN uv pip install -r requirements.txt

USER root
