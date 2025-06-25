#!/usr/bin/env bash
#
# Check that the dependencies of all bv-evaluation python scripts are installed
# 

shopt x
cd $(dirname "$(realpath "$0")")

FILE=$(mktemp)
exec 3<> "$FILE"    # Open tmpfile on file descriptor 3
rm "$FILE"          # Unlink tmpfile
# NOTE: we can still read and write to the file on the file descriptor, this way
#       the tmpfile gets automatically cleaned up when the script exits

cat *.py | rg '^import' | sed -E 's/\s*(as \w+)?\s*$//' | sort -u | tee /proc/self/fd/3

python3 /proc/self/fd/3 || (
    echo
    echo "To fix, please add the missing dependency to shell.nix"
    echo
    exit 1
)
