## How to run

To repreoduce the mca analysis results, run: 
```
python3 run_mca.py 
```

This file will run LLVM's `llvm-mca` tool on the RISCV assembly files produced by both LLVM and Lean-MLIR + XDSL, using the following command: 
```
llvm-mca -mtriple=riscv64 -mcpu=sifive-u74 -mattr=+m,+zba,+zbb,+zbs $input_file
```

The results of the analysis and the log of the tool are available in `results/`.
