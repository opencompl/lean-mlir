set -o xtrace
set -e
lake -R -Kenv=dev update
lake -R exe cache get # load mathlib from cache
# make a phony build/doc if doc-gen fails.
lake -R -Kenv=dev build SSA:docs || mkdir -p build/doc # Alive depends on SSA.
