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
USER user

# Install elan and update environment
RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none
ENV PATH=/home/user/.elan/bin:$PATH

# Download and unzip SMT-LIB QF_BV benchmarks
# RUN mkdir -p bv-evaluation/SMT-LIB
# RUN curl -L -o QF_BV.tar.zst https://zenodo.org/records/15493090/files/QF_BV.tar.zst?download=1 && \
#     tar -xf QF_BV.tar.zst -C bv-evaluation/SMT-LIB && \
#     rm QF_BV.tar.zst
# # Store all paths of SMT-LIB benchmarks into smtlib_all.txt
# RUN cd bv-evaluation && find SMT-LIB -type f -name "*.smt2" > smtlib_all.txt && \
#     sort smtlib_all.txt -o smtlib_all.txt && \
#     python3 -c "import random,sys; lines = open('smtlib_all.txt').readlines(); random.seed(42); random.shuffle(lines); open('smtlib_all.txt', 'w').writelines(lines)"

# Create Solvers directory
# RUN mkdir -p bv-evaluation/solvers

# Install Bitwuzla (commit: 22.6.25)
RUN git clone https://github.com/bitwuzla/bitwuzla && cd bitwuzla && git checkout 0dca38d0f62fa9002ad6278ca6374838a69ade19
RUN cd bitwuzla && ./configure.py && cd build && ninja && sudo ninja install

# Install CoqQFBV (commit: 09.04.23)
# RUN cd bv-evaluation/solvers && git clone https://github.com/fmlab-iis/coq-qfbv && cd coq-qfbv && git checkout bb055f7b05dd81a5ddf89c734bde140a9feecf70
# WORKDIR bv-evaluation/solvers/coq-qfbv
# RUN yes "/usr/local/bin" | bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)" && \
#     opam init --disable-sandboxing --bare
# RUN opam switch create ocaml-base-compiler.4.14.0
# RUN eval $(opam env) && \
#     opam repo add coq-released https://coq.inria.fr/opam/released && \
#     opam pin --yes coq 8.15.2 && \
#     opam pin --yes coq-mathcomp-ssreflect 1.14.0 && \
#     opam install --yes coq-mathcomp-algebra
# RUN git submodule init && \
#     git submodule update && \
#     eval $(opam env) && \
#     make -C lib/coq-nbits && \
#     make -C lib/coq-ssrlib && \
#     make
# RUN cd src/ocaml && eval $(opam env) && dune build
# RUN mkdir bin
# RUN cp src/ocaml/_build/default/coqQFBV.exe bin/coqQFBV.exe
# # Install Kissat (version: 4.0.1)
# RUN cd bin && \
#     curl -L -o kissat-4.0.1-linux-amd64.zip https://github.com/arminbiere/kissat/releases/download/rel-4.0.1/kissat-4.0.1-linux-amd64.zip && \
#     unzip -j kissat-4.0.1-linux-amd64.zip && \
#     mv kissat-4.0.1-linux-amd64 kissat && \
#     rm kissat-4.0.1-linux-amd64.zip
# Install GRATgen (version: 1.3.2)
# RUN cd lib && \
#     curl -L -o gratgen.tgz https://www21.in.tum.de/~lammich/grat/archive/v1.3.2/gratgen.tgz && \
#     tar -xzf gratgen.tgz && \
#     rm gratgen.tgz && \
#     cd gratgen && \
#     sed -i '16a add_definitions(-DBOOST_TIMER_ENABLE_DEPRECATED)' CMakeLists.txt && \
#     mkdir build && cd build && \
#     cmake -DCMAKE_BUILD_TYPE=Release .. && \
#     make && \
#     cp gratgen ../../../bin
# Install GRATchk (version: 1.3.2)
# RUN cd lib && \
#     curl -L -o gratchk-sml.tgz https://www21.in.tum.de/~lammich/grat/archive/v1.3.2/gratchk-sml.tgz && \
#     tar -xzf gratchk-sml.tgz && \
#     rm gratchk-sml.tgz && \
#     cd gratchk-sml && make && \
#     cp gratchk ../../bin
# WORKDIR /home/user/lean-mlir

# Install Leanwuzla (commit: 25.06.25)
# This is a fork of Leanwuzla with modifications to support the evaluation
# RUN cd bv-evaluation/solvers && git clone https://github.com/abdoo8080/Leanwuzla && \
#     cd Leanwuzla && git checkout 3ec8c974eed8f4d142a5d3422feb8220d0661089 && \
#     lake build

# install plotting script dependencies
RUN python3 -m venv .venv && \
    .venv/bin/pip install -r requirements.txt

# get cached dependencies
# COPY --chown=user:group . .

# build lean-mlir
# Install Lean-MLIR (commit: 26.06.25)
RUN cd /home/user && git clone https://github.com/opencompl/lean-mlir && cd lean-mlir && git checkout 7bd8c716a4a0bd5608279f0b73bd6c87f78c9f1c 
WORKDIR /home/user/lean-mlir
RUN lake update & lake build

# setup python env
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"


# Set the evaluation script directory as working dir
WORKDIR /code/lean-mlir/bv-evaluation/
RUN python3 collect-data-llvm.py hackersdelight -j4 -r5
RUN python3 compare.py instcombine -j4 -r5

RUN ./collect-data-hdel.py 
RUN ./collect-data-llvm.py

WORKDIR /code/lean-mlir/bv-evaluation/for-paper/tools/
RUN for-paper/tools; python3 ./collect-stats.py

USER root
