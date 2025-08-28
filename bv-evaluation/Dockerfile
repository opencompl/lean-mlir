FROM ubuntu:25.04

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	apt-get update && \
	apt-get install -yqq --no-install-recommends \
        elan \
        wget unzip python3 ca-certificates \
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
