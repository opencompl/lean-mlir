.PHONY: docker-build docker-build-debug clean

artifact.pdf: artifact.tex sigplanconf.cls
	latexmk -pdf -shell-escape artifact.tex

docker:
	podman build -t oopsla25-bv-decide --progress plain .
	podman save -o ./oopsla25-bv-decide.tar oopsla25-bv-decide

clean:
	latexmk -C