set -o xtrace
set -e
lake -Kenv=dev update
lake exe cache get # load mathlib from cache
# make a phony build/doc if doc-gen fails.
lake -Kenv=dev build SSA:docs || mkdir -p build/doc # Alive depends on SSA.
