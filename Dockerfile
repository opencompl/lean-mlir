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

# Build the framework.
# See note at the end for more details
# about the caching boilerplate
COPY . ./
RUN --mount=type=cache,target=$HOME/.cache/mathlib,sharing=private,uid=$UID \
    --mount=type=cache,target=$HOME/.cache/LeanMLIR,sharing=private,uid=$UID \
  # \
  # Symlink cache into place \
  # \
  ln -s $HOME/.cache/LeanMLIR/ .lake && \
  # \
  # Actual Build \
  # \
  lake build && \
  # \
  # Persist .lake into Docker image \
  # \
  rm .lake && \
  cp -Ra $HOME/.cache/LeanMLIR .lake

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
#     `.lake` to this cache-mounted path. 
# - Run the build as usual; this will both use
#     the cached outputs of previous builds and ensures
#     the outputs of the current build are made cached.
# - Finally, we remove the symlink, and *copy* all files,
#     which copies the file from the cached directory into
#     the actual Docker image.
#
# Because we have this cache setup, we don't have to worry
# about installing dependencies in a separate layer.
# Instead, we cache our dependencies the same way 
# we cache our incremental build artifacts.

