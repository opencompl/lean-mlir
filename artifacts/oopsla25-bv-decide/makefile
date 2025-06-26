.PHONY: docker-build docker-build-debug clean

artifact.pdf: artifact.tex sigplanconf.cls
	latexmk -pdf -shell-escape artifact.tex

docker-build-and-push:
	docker build -t  artifact-evaluation/Dockerfile -t lean-image .
	docker create --name temp-container lean-image
	docker cp temp-container:/code/lean-mlir/bv-evaluation/raw-data ./docker-results
	docker rm temp-container

clean:
	latexmk -C