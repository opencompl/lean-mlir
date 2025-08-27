FROM ubuntu:25.04

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  apt-get update && \
  apt-get install -yqq --no-install-recommends \
    ca-certificates curl \
    git

# Ensure CA certificates are up-to-date
RUN update-ca-certificates -f

# Install elan and update environment
WORKDIR /code

RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none
ENV PATH=/root/.elan/bin:$PATH

WORKDIR /code/lean-mlir

# Install Lean & checkout dependencies.
# I agree this looks funky.
# The idea is that we setup just enough of the lakefile and lake-manifest
# such that we can run a `lake env echo`.
# This then lets us copy the framework *after* a build.
# This way, Docker does not have to re-download the dependencies every time the code changes
COPY lean-toolchain lakefile.* lake-manifest.json TacBench/lean-toolchain TacBench/lakefile.* TacBench/lake-manifest.json ./
RUN lake env echo

# Build the framework
COPY . ./
RUN --mount=type=cache,target=/root/.cache/mathlib \
  lake exe cache get && lake build
