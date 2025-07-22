#!/usr/bin/env bash

set -o xtrace

pushd "$(git rev-parse --show-toplevel)" || exit 1

python3 SSA/Projects/InstCombine/scripts/extract-goals.py --nfiles 9000 -j7
OUT=$(git diff SSA/Projects/InstCombine/tests/goals/)
echo "$OUT"
if [[ -n "$OUT" ]]; then
  echo "Goals have changed. Please commit the changes. ❌"
  exit 1
fi

echo "Goals are up-to-date ✅"

