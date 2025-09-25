#!/usr/bin/env bash

if [[ -z "$CACHE_MOUNT" ]]; then
    echo "error: \$CACHE_MOUNT not set"
    exit 1
fi

setup() {
    for lakefile in {**,.}/lakefile.*; do
        lake_dir="$(dirname "$lakefile")/.lake"
        if [[ -L "$lake_dir" ]]; then
            continue
        fi

        mkdir -p "$CACHE_MOUNT/$lake_dir"
        ln -Ts "$CACHE_MOUNT/$lake_dir" "$lake_dir"
    done
}

teardown() {
    for lake_dir in {**,.}/.lake; do
        if [[ -L "$lake_dir" ]]; then
            rm "$lake_dir"
            cp -TRa "$CACHE_MOUNT/$lake_dir" "$lake_dir"
        fi
    done
}

case "$1" in
    setup) setup;;
    teardown) teardown;;
    *)
        echo "error: unknown subcommand `$1`"
        exit 1
        ;;
esac