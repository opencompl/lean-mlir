#!/usr/bin/env bash

DOCKER_IMAGE_TAG="opencompl/lean-mlir-bv-evaluate"

#TODO: I'm not sure exactly what data the experiment sripts consume/generate;
#      we should add a mount to make sure that data is synced between the host and
#      image filesystems
docker run -t "$DOCKER_IMAGE_TAG" "$@"
