
# MCA Analysis

## Dependencies

This evaluation requires `llvm-mca`, either install it through your favourite
package manager, or, if you've built LLVM from source, add the `bin` directory
to your path.

For example, if you've built LLVM at `~/llvm-project/build`, and you run bash as
your shell, you should run the following before you run the script:

```bash
export PATH=$PATH:~/llvm-project/build/bin/
```

To make sure that `evallib` is correctly imported, run: 

```bash
export PYTHONPATH=$PYTHONPATH:~/lean-mlir
```

## How to run

To reproduce the mca analysis results, run:
```
python3 run_mca.py 
```


This file will run LLVM's `llvm-mca` tool on the RISCV assembly files produced by LLVM with `globalISel`, LLVM with `selectionDAG`, Lean-MLIR + XDSL and Lean-MLIR with optimizations + XDSL using the following command: 

```
llvm-mca -mtriple=riscv64 -mcpu=sifive-u74 -mattr=+m,+zba,+zbb,+zbs $input_file
```

The results of the analysis and the log of the tool are available in `results/`.

To reproduce the plots, run 
```
python3 plot.py
```