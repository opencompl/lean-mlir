FROM ubuntu:24.04
WORKDIR /code

# install dependencies
RUN apt-get update -y \
    && DEBIAN_FRONTEND="noninteractive" apt-get install --yes \
        tzdata \
	pip \
	python3-venv \
        build-essential \
        cmake \
        git \
        ninja-build \
        gdb curl wget \
        # dependencies for experiment scripts
        python3-matplotlib python3-pandas python3-num2words \
        # bitwuzla dependencies
        meson libgmp-dev libcadical-dev libsymfpu-dev pkg-config

ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

# install Lean
RUN curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf > /code/elan.sh \
    && sh /code/elan.sh -y # elan
ENV PATH /root/.elan/bin:$PATH
ENV LIBRARY_PATH /root/.elan/lib:$LIBRARY_PATH

# install Bitwuzla (commit: 22.6.25)
RUN git clone https://github.com/bitwuzla/bitwuzla && cd bitwuzla && git checkout 0dca38d0f62fa9002ad6278ca6374838a69ade19
WORKDIR /code/bitwuzla
RUN ./configure.py && cd build && ninja install

# install Lean-MLIR (commit: 22.06.25)
RUN git clone https://github.com/opencompl/lean-mlir && cd lean-mlir && git checkout b0253c5f5dbc6cc507b559d76fd659da38a8e565 
WORKDIR /code/lean-mlir

# get cached dependencies
WORKDIR /code/lean-mlir
COPY . .

RUN lake exe cache get
RUN lake build

# setup python env
RUN uv venv /opt/venv
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN uv pip install -r requirements.txt


# Set the evaluation script directory as working dir
WORKDIR /code/lean-mlir/bv-evaluation/
RUN ./compare hackersdelight -j4 -r5
RUN ./compare instcombine -j4 -r5

RUN ./collect-data-hdel.py 
RUN ./collect-data-llvm.py

WORKDIR /code/lean-mlir/bv-evaluation/for-paper/tools/
RUN for-paper/tools; python3 ./collect-stats.py

USER root
