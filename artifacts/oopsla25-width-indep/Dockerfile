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

ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

# Install Lean
RUN curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf > /code/elan.sh \
    && sh /code/elan.sh -y # elan
ENV PATH /root/.elan/bin:$PATH
ENV LIBRARY_PATH /root/.elan/lib:$LIBRARY_PATH

# Download & build lean-mlir
RUN curl -L https://github.com/opencompl/lean-mlir/archive/refs/heads/main.tar.gz > /code/lean-mlir.tar.gz # SSA tar file
RUN tar xf lean-mlir.tar.gz && ls /code/ && mv lean-mlir-main lean-mlir # untar
WORKDIR /code/lean-mlir
RUN lake -R exe cache get
RUN lake build

# setup python env
RUN uv venv /opt/venv
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN uv pip install -r requirements.txt

WORKDIR /code/lean-mlir/bv-evaluation
RUN ./compare-automata-automata-circuit-jsonl.py --db compare.jsonl -prodrun  -j5 
RUN ./plot-automata-automata-circuit-jsonl.py compare.jsonl

WORKDIR /code/lean-mlir/SSA/Experimental/Bits/Fast/Dataset2
RUN ./runner.py --db mba.sqlite3 -j10 --prod-run --timeout 8000
RUN ./plotter.py mba.sqlite3

USER root
