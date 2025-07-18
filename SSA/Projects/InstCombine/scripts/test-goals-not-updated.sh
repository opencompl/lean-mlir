#!/usr/bin/env bash
set -o xtrace
set -e # fail on errors.

cd "$(git rev-parse --show-toplevel)"
python3 SSA/Projects/InstCombine/scripts/extract-goals.py -n 500000 -j20
CHANGED=$(git diff SSA/Projects/InstCombine/scripts)

echo "$CHANGED"

if [[ -n "$CHANGED" ]]; then
  echo "Goals changed. Please commit the changes. ❌"
  exit 1
fi

echo "Goals up to date. ✅"
