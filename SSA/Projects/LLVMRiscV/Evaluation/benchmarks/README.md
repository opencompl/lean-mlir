# Benchmarks Generation 

### Dependencies 

This evaluation requires LLVM's static compiler (`llc`), either install it through your favourite
package manager, or, if you've built LLVM from source, add the `bin` directory
to your path.

For example, if you've built LLVM at `~/llvm-project/build`, and you run bash as
your shell, you should run the following before you run the script:

```bash
export PATH=$PATH:~/llvm-project/build/bin/
```

Our evaluation also depends on [mlir-fuzz](https://github.com/opencompl/mlir-fuzz) to produce the initial synthetic programs, and it needs to be installed to run `generate_multi.py`


### How to run

To generate the initial fuzzed programs, run: 
```
python3 generate_multi.py --num --max_size --min_size
```

For each `size` in the interval `[min_size, max_size]`, the script saves to `benchmarks/MLIR_multi` 
a single file `out_size.mlir` containing `num` programs. 
This will be the starting point of the conversion.

To generate the remaining benchmarks, run: 
```
python3 generate.py --num --jobs
```

The script `generate.py` populates the folders in `benchmarks` by running the following: 
- For each file in `MLIR_multi`, extract `num` single MLIR modules and save them in `benchmarks/MLIR_single/`. Each file containing a single module will have two numbers that remain consistent throughout the lowering (e.g. `size_function_num`, where `size` is the initial program size specified in `generate_multi.py`). 
- using `mlir-opt`, convert each of these files containing a single module to the LLVM dialect, save the result in `benchmarks/LLVM/*.ll`

Then, the scripts lowers all the files using both LLVM and Lean-MLIR, to enable the comparison of the lowered RISCV assembly output. 

*LLVM toolchain*
- using `mlir-translate`, convert the `*.ll` files in LLVMIR, and save the result in `benchmarks/LLVMIR/*.mlir`
- using `llc` with `selectionDAG`, compile the LLVMIR files to the `riscv` backend and save the result in `benchmarks/LLC_ASM_selectiondag/*.s`
- using `llc`, compile the LLVMIR files to the `riscv` backend and save the result in `benchmarks/LLC_ASM_globalisel/*.s`

*Lean-MLIR toolchain*
- extract the first block `bb0` from the `*.ll` files and save the result in `benchmarks/MLIR_bb0/*.mlir`
- run the Lean-MLIR lowering to RiscV and save the result in `benchmarks/LEANMLIR_ASM/*.mlir`, potentially in parallel by setting the `jobs` input argument (the default number is 1).
- run the Lean-MLIR optimized lowering to RiscV and save the result in `benchmarks/LEANMLIR_ASM_opt/*.mlir`, potentially in parallel by setting the `jobs` input argument (the default number is 1).
- remove `unrealized_cast` operations from the assembly file using XDSL, save the result in `benchmarks/XDSL_no_casts/*.mlir`
- remove `unrealized_cast` operations from the optimized assembly file using XDSL, save the result in `benchmarks/XDSL_no_casts_opt/*.mlir`
- perform register allocation using XDSL, save the result in `benchmarks/XDSL_reg_alloc/*.mlir`
- perform register allocation using XDSL on optimized assembly, save the result in `benchmarks/XDSL_reg_alloc_opt/*.mlir`
- lower to RISCV assembly using XDSL, save the result in `benchmarks/XDSL_ASM/*.mlir`
- lower optimized assembly to RISCV using XDSL, save the result in `benchmarks/XDSL_ASM_opt/*.mlir`

Each step in `generate.py` produces a log file, which one can retrieve in `logs/`. The names in the log file contain the function and the pass that outputted that file.

### How to reuse and customize
- to add new MLIR tests, add a file to `benchmarks/MLIR_multi`. Files in this folder at the moment are named according to the followign convention: `out_` + number of MLIR modules in the file + `.mlir`.