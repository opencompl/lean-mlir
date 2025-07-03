ARG NIXOS_VERSION="25.05"
ARG SYSTEM="x86_64-linux"
FROM nixpkgs/nix:nixos-$NIXOS_VERSION-$SYSTEM AS opencompl/lean-mlir

# Enable flakes and set up nix configuration
RUN mkdir -p /etc/nix && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# Add the nix profile to path
ENV PATH="${PATH}:/root/.nix-profile/bin"

# Install the development environment package
RUN mkdir -p /code/lean-mlir
WORKDIR /code/lean-mlir

COPY flake.nix flake.lock ./
RUN nix profile install ".#"

# Install Lean & checkout dependencies
COPY lean-toolchain lakefile.* ./
RUN lean-mlir-init-env

COPY . ./
