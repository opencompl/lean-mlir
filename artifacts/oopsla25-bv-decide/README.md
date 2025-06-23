# Artifact for AE

#### Build docker image and extract results

from folder lean-mlir: 
- docker build -f artifact-evaluation/Dockerfile -t lean-image .
- docker create --name temp-container lean-image
- docker cp temp-container:/code/lean-mlir/bv-evaluation/raw-data ./docker-results
- docker rm temp-container