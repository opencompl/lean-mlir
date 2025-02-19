
DOCKER=podman
DOCKER_IMAGE_TAG=opencompl/lean-mlir-bv-evaluate

docker-image:
	${DOCKER} build -f Dockerfile ../ -t "${DOCKER_IMAGE_TAG}"

.PHONY: 

*.py:   .PHONY  
	./run-script.sh python3 $@

clean:
	docker rmi ${DOCKER_IMAGE_TAG}

all: 
	./run-script.sh ./run-tests.sh
