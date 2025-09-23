# syntax=docker/dockerfile:1.7-labs
# ^^ Needed for `COPY --parent` flag


FROM ubuntu:25.04 AS mathlib-files

# 
# First, we search for any imports of Mathlib, Qq or Lean, and collect them
# in a `Dependencies.lean` file. This file is used in the main build stage
# to build dependencies in a separate layer, for better caching.
#
# If you see a dependency being (re)built in the main build layer, where you 
# expected it be built in the dependencies layer, double check that the `grep`
# line below finds your import.
#
RUN --mount=type=bind,source=.,target=/code/lean-mlir-src \
  cd /code/lean-mlir-src && \
  grep --no-filename --recursive --only-matching -E 'import (Mathlib|Qq|Lean|Batteries|Cli)\S*' SSA/ \
    | sort -u > /code/Dependencies.lean 

FROM ubuntu:25.04

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  apt-get update && \
  apt-get install -yqq --no-install-recommends \
    ca-certificates curl \
    git

# Ensure CA certificates are up-to-date
RUN update-ca-certificates -f

# Set user env vars
ENV UID=0
ENV HOME=/root

# Install elan and update environment
RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none
ENV PATH=$HOME/.elan/bin:$PATH

#
# Install Lean.
#
# We copy only the minimal number of files needed,
# so that Docker does not invalidate the cached 
# image layer every time the code changes.
WORKDIR /code/lean-mlir
COPY lean-toolchain ./
RUN lake --version 
# ^^ Force lake to install the specified version

# Download and build dependencies.
# See note at the end for more details about the caching boilerplate
COPY --parents **/lakefile.* **/lake-manifest.* ./
COPY --from=mathlib-files /code/Dependencies.lean ./SSA/Dependencies.lean
RUN --mount=type=cache,target=$HOME/.cache/LeanMLIR,sharing=private \
  # Symlink cache into place
  mkdir .lake && \
  mkdir -p $HOME/.cache/LeanMLIR/.lake/packages && \
  ln -Ts $HOME/.cache/LeanMLIR/.lake/packages .lake/packages && \
  # Build
  lake build SSA.Dependencies && \
  rm -r .lake/build && \ 
  # ^^ We don't actually want the oleans for the `Dependencies` file
  # Persist .lake into Docker image 
  rm .lake/packages && \
  cp -TRa $HOME/.cache/LeanMLIR/.lake/packages .lake/packages

# Build the framework.
# See note at the end for more details about the caching boilerplate
COPY . ./
RUN --mount=type=cache,target=$HOME/.cache/mathlib,sharing=private \
    --mount=type=cache,target=$HOME/.cache/LeanMLIR,sharing=private \
  # Symlink cache into place
  CACHE="$HOME/.cache/LeanMLIR" && \
  mkdir -p $CACHE/Blase/.lake $CACHE/.lake/build Blase/ && \
  ln -Ts $CACHE/Blase/.lake Blase/.lake && \
  ln -Ts $CACHE/.lake/build .lake/build && \
  # Actual Build
  lake build && \
  # Persist .lake into Docker image
  rm .lake/build Blase/.lake && \
  cp -TRa $CACHE/.lake/build .lake/build && \
  cp -TRa $CACHE/Blase/.lake Blase/.lake

# The previous RUN uses cache-mounts to speed up 
# builds. Note, however, that the paths which were
# mounted do *not* get saved in the Docker image.
#
# For our use-case, we want to cache the .lake folder,
# since our dependencies and the incremental build outputs
# of previous builds are stored there, but we also *need*
# the build outputs (which are stored in .lake) to be 
# persisted in the image!
#
# Thus, to work around this behaviour, we:
# - Mount a different path (under `/root/.cache`), and symlink
#     `.lake` or a subfolder like `.lake/build` to this cache-mounted path. 
# - Run the build as usual; this will use cached outputs of previous builds, if 
#     available, and ensures the outputs of the current build are written to the 
#     cache for use by subsequent builds.
# - Finally, we remove the symlink, and *copy* all files,
#     which copies the file from the cache-mounted directory into
#     the actual Docker image.
#


