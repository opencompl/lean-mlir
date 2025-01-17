#!/usr/bin/env bash

DOCKER_IMAGE_TAG="opencompl/lean-mlir-bv-evaluate"

EVAL_DIR="/code/lean-mlir/bv-evaluation"
MOUNTS="
  --mount type=bind,src='./raw-data',dst='$EVAL_DIR/raw-data' 
  --mount type=bind,src='./results',dst='$EVAL_DIR/results'
"

#TODO: I'm not sure exactly what data the experiment sripts consume/generate;
#      we should add a mount to make sure that data is synced between the host and
#      image filesystems
docker run -t "$DOCKER_IMAGE_TAG" $MOUNTS "$@"
