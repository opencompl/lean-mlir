ARG NIXOS_VERSION="25.05"
ARG SYSTEM="x86_64-linux"
FROM nixpkgs/nix:nixos-$NIXOS_VERSION-$SYSTEM

# Enable flakes and set up nix configuration
RUN mkdir -p /etc/nix && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# Add the nix profile to path
ENV PATH="${PATH}:/root/.nix-profile/bin"

# Install busybox, for `adduser`
RUN nix profile install "nixpkgs#busybox"

# Install the development environment package
# To add another package to be installed in the Dockerfile,
# please modify the `flake.nix` file.
RUN mkdir -p /code/lean-mlir
WORKDIR /code/lean-mlir

COPY flake.nix flake.lock ./
RUN nix profile install ".#"

# Install Lean.
# We copy only the minimal number of files needed,
# so that Docker does not invalidate the cached 
# image layer every time the code changes.
COPY lean-toolchain ./
RUN lake --version 
# ^^ Force lake to install the specified version

# Build the framework.
# See note at the end for more details
# about the caching boilerplate
COPY . ./
RUN --mount=type=cache,target=/root/.cache/mathlib \
    --mount=type=cache,target=/root/.cache/LeanMLIR,sharing=private \
  # \
  # Symlink cache into place \
  # \
  ln -s /root/.cache/LeanMLIR/ .lake && \
  # \
  # Actual Build \
  # \
  lake exe cache get && lake build && \
  # \
  # Persist .lake into Docker image \
  # \
  rm .lake && \
  cp -Ra /root/.cache/LeanMLIR .lake

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

