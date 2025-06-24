.PHONY: docker-build docker-build-debug clean
artifact.pdf: artifact.tex sigplanconf.cls
	latexmk -pdf -shell-escape artifact.tex

docker-build-and-push:
	docker build -t opencompl-ssa --progress plain .
	docker save -o ./opencompl-ssa.tar opencompl-ssa
	docker push siddudruid/opencompl-ssa

clean:
	latexmk -C
