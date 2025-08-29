# syntax=docker/dockerfile:1.7-labs

FROM ubuntu:25.04 as dependencies
# This first stage just computes imports of dependencies
# We do this to optimize for cache utilization, see the note further down
# in the main stage for details.

WORKDIR /code/lean-mlir/SSA
SHELL ["/bin/bash", "-c"]
# ^ We need bash for `{foo,bar}` expansion
RUN --mount=type=bind,source=./,target=/mnt/lean-mlir \
  grep --no-filename --recursive --only-matching -E 'import (Mathlib|Qq|Lean)\S*' \ 
        /mnt/lean-mlir/SSA/ \
    | sort -u > Imports.lean

FROM ubuntu:25.04

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  apt-get update && \
  apt-get install -yqq --no-install-recommends \
    ca-certificates \
    curl \
    rsync \
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
### Docker Layer Caching
#
# Recall that Docker will cache each build step in a separate layer.
# For a `COPY` step, this cache gets invalidated when *any* of the copied
# files change. For this reason, we *don't* copy all of LeanMLIR into the image
# in one step. Instead, we copy, and act on, the bits which don't change 
# frequently first. For example, by installing the Lean toolchain specified by
# the lean-toolchain file in a separate layer, we maximize the chance this is
# cached.

#
# Install Lean toolchain
#
# *NOTE*: we only install the toolchain specified by the root project, 
#         assuming that subprojects follow this toolchain
#
WORKDIR /code/lean-mlir
COPY lean-toolchain ./
RUN lake --version 
# ^^ Force lake to install the specified version

#
# Fetch Dependencies
#
COPY --parents **/lean-toolchain **/lakefile.* **/lake-manifest.* ./
RUN lake env echo
# ^^ Get lake to fetch dependencies, without building them
#    NOTE: `lake update` is not appropriate here, as that would ignore the versions
#          locked in manifest file (instead updating to the latest version allowed)

#
# Fetch Cache & build dependencies
#
COPY ./.dockerscripts ./dockerscripts
# RUN --mount=type=cache,target=$HOME/.cache/mathlib,sharing=private,uid=$UID \
#     --mount=type=cache,target=$HOME/.cache/LeanMLIR,sharing=private,uid=$UID \
#   # Setup (Docker) cache
#   ./dockerscripts/cache_setup.sh $HOME/.cache/LeanMLIR .lake && \
#   # Fetch (Lean) cache
#   lake exe cache get && \
#   # 
#   ./dockerscripts/cache_teardown.sh $HOME/.cache/LeanMLIR .lake
# COPY --from=dependencies /code/lean-mlir/SSA/Imports.lean ./SSA/
# RUN lake build SSA/Imports.lean

# #
# # Build the framework.
# #
# # See note at the end for more details
# # about the caching boilerplate
# COPY . ./
# RUN --mount=type=cache,target=$HOME/.cache/LeanMLIR,sharing=private,uid=$UID \
#   # \
#   # Setup cache  \
#   # \
#   ./dockerscripts/cache_setup.sh $HOME/.cache/LeanMLIR .lake && \
#   # \
#   # Actual Build \
#   # \
#   lake build && \
#   # \
#   # Persist .lake into Docker image \
#   # \
#   ./dockerscripts/cache_teardown.sh $HOME/.cache/LeanMLIR .lake

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

