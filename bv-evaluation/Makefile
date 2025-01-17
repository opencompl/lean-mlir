
DOCKER=podman
DOCKER_IMAGE_TAG=opencompl/lean-mlir-bv-evaluate

docker-image:
	${DOCKER} build -f Dockerfile ../ -t "${DOCKER_IMAGE_TAG}"

*.py: docker-image
	./run-script $@

clean:
	docker rmi ${DOCKER_IMAGE_TAG}

all: 
	./run-script --entrypoint=/usr/bin/sh run-tests.sh