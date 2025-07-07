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

# Install Lean & checkout dependencies
COPY lean-toolchain lakefile.* lake-manifest.json ./
RUN lean-mlir-init-env

# Build the framework
COPY . ./
RUN --mount=type=cache,target=/root/.cache/mathlib \
  lake exe cache get && lake build
