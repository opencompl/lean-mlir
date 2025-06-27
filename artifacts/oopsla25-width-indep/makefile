.PHONY: docker-build docker-build-debug clean
artifact.pdf: artifact.tex sigplanconf.cls
	latexmk -pdf -shell-escape artifact.tex

docker-build-and-push:
	podman build -t oopsla25-width-indep --progress plain .
	podman save -o ./oopsla25-width-indep.tar oopsla25-width-indep
	docker push siddudruid/oopsla25-width-indep

clean:
	latexmk -C
