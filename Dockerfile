# syntax=docker/dockerfile:1.7-labs
# ^^ Needed for `COPY --parent` flag

FROM ubuntu:25.04 AS lean-mlir-base

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

#
# For cache optimality, we want dependencies to be built in a separate layer
# from our own code. However, actually separating this into separate `RUN` 
# commands is complex. Thus, we introduce a builder phase which builds everything
# in a straightforward, non-optimized way.
# Then, in the actual image is based on `lean-mlir-base`, but copies the source
# code and build artifacts in cache-optimized layers.
#
FROM lean-mlir-base as lean-mlir-build

# Build everything (dependencies & our code)
COPY . ./
RUN --mount=type=cache,target=$HOME/.cache/LeanMLIR,sharing=private \
  # Symlink cache into place
  CACHE="$HOME/.cache/LeanMLIR" && \
  mkdir -p $CACHE/.lake && \
  ln -Ts $CACHE/.lake .lake && \
  #
  # Build
  lake build && \
  #
  # Persist .lake into Docker image 
  rm .lake && \
  # ^^ Removes the symlink
  cp -TRa $CACHE/.lake .lake
  # ^^ Copies the contents to a new `.lake` folder

# NOTE: we deliberately don't use `lake exe cache get`, as that would download
# all of Mathlib, which is much more than we need, and the extra codesize 
# significantly increases the image size, slowing down downloads.
# By building Mathlib from scratch, we ensure we only build the files we actually
# use, making the image smaller.

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


FROM lean-mlir-base as lean-mlir

# The following is functionally equivalent to COPYing `/code/lean-mlir` from the
# builder phase into the current image. However, we spread this copy out over
# multiple, partitioned copies, so that we get multiple layers.
#
# Furthermore, using `--link`[1] creates independent layers, so that a COPY won't
# get cache invalidated just because a previous layer changed.
#
# [1]: https://docs.docker.com/reference/dockerfile/#copy---link

COPY --link --from=lean-mlir-build /code/lean-mlir/.lake/packages ./lake/packages/
COPY --link --from=lean-mlir-build /code/lean-mlir/.lake/build ./lake/build/
COPY --link --from=lean-mlir-build --parents /code/lean-mlir/*/.lake ./
COPY --link --from=lean-mlir-build --exclude=**/.lake /code/lean-mlir ./

