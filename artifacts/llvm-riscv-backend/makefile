.PHONY: docker-build docker-build-debug clean

artifact.pdf: artifact.tex sigplanconf.cls
	latexmk -pdf -shell-escape artifact.tex

docker:
	podman build -t llvm-riscv-backend --progress plain .
	podman save -o ./llvm-riscv-backend.tar llvm-riscv-backend

clean:
	latexmk -C