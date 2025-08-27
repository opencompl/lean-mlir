#!/usr/bin/env bash
GIT_ROOT=$(git rev-parse --show-toplevel)
uv run snakemake all --cores all --show-failed-logs

