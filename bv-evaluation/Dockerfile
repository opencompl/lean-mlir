ARG LEANMLIR_TAG="latest"
FROM ghcr.io/opencompl/lean-mlir:${LEANMLIR_TAG} AS lean-mlir

FROM ubuntu:25.04

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	apt-get update && \
	apt-get install -yqq --no-install-recommends \
        python3 \
        curl wget unzip ca-certificates \
        # evaluation tools
        ripgrep \
        # bitwuzla dependencies
        git ninja-build build-essential \
        meson libgmp-dev libcadical-dev libsymfpu-dev pkg-config

# Ensure CA certificates are up-to-date
RUN update-ca-certificates -f

WORKDIR /code

# Build & Install Bitwuzla
ADD --keep-git-dir=true \
    https://github.com/bitwuzla/bitwuzla.git#0dca38d0f62fa9002ad6278ca6374838a69ade19 bitwuzla/
RUN \
    cd bitwuzla && \
    ./configure.py && \
    cd build && ninja && ninja install

# Drop privilege to non-root user
ENV UID=9000
ENV HOME=/home/user
RUN \
  useradd user --create-home --uid $UID --home-dir="$HOME" && \
  mkdir -p /code/lean-mlir && \
  mkdir -p /github/home && \
  chown -R user /code /github/home
USER user
WORKDIR $HOME
RUN ln -s $HOME/.elan /github/home/.elan
  # ^^ Github Actions overrides the home directory [1]. Rather than fight it we
  #    choose to symlink our stuff in the directory it expects.
  #    [1] https://github.com/actions/runner/issues/863

# Install uv
ADD --link --chown=$UID https://astral.sh/uv/0.8.13/install.sh ./uv-installer.sh
RUN sh ./uv-installer.sh && rm ./uv-installer.sh
ENV PATH="$HOME/.local/bin/:$PATH"

# Switch to Lean MLIR workdir
WORKDIR /code/lean-mlir/

# Install LeanMLIR Python dependencies (via uv)
COPY --link --from=lean-mlir --chown=$UID /code/lean-mlir/requirements.txt ./
RUN uv venv && uv pip install -r requirements.txt

# Copy LeanMLIR toolchain & build artifacts from image
COPY --link --from=lean-mlir --chown=$UID $HOME/.elan/ $HOME/.elan/
COPY --link --from=lean-mlir --chown=$UID /code/lean-mlir/ /code/lean-mlir/
ENV PATH="$HOME/.elan/bin/:$PATH"