## How to run

To generate the benchmarks, run: 
```
python3 generate.py --input --num --jobs
```

The script `generate.py` populates the folders in `benchmarks` by running the following: 
- Starting from the `input` file with multiple functions, extract `num` single MLIR modules and save them in `benchmarks/MLIR_single/`. Each file containing a single module will have a number, that remains consistent throughout the lowering. `input` is by default `benchmarks/MLIR_multi/out_1000.mlir`, which contains 1000 modules. `num` specifies how may modules will be extracted. 
- using `mlir-opt`, convert each of these files containing a single module to the LLVM dialect, save the result in `benchmarks/LLVM/*.ll`
- then, the scripts lowers all the files using both LLVM and Lean-MLIR, to enable the comparison of the lowered RISCV assembly output. 

*LLVM toolchain*
- using `mlir-translate`, convert the `*.ll` files in LLVMIR, and save the result in `benchmarks/LLVMIR/*.mlir`
- using `llc`, compile the LLVMIR files to the `riscv` backend and save the result in `benchmarks/LLC_ASM/*.s`
- using `llc`, compile the LLVMIR files to the `riscv` backend and save the result in `benchmarks/LLC_ASM/*.s`

*Lean-MLIR toolchain*
- extract the first block `bb0` from the `*.ll` files and save the result in `benchmarks/MLIR_bb0/*.mlir`
- run the Lean-MLIR lowering to RiscV and save the result in `benchmarks/LEANMLIR_ASM/*.mlir`, potentially in parallel by setting the `jobs` input argument (the default number is 1).

Each step in `generate.py` produces a log file, typically empty: after the generation is complete we go through these logs and only leave the files with meaningful content.

### How to reuse and customize
- to add new MLIR tests, add a file to `benchmarks/MLIR_multi`. Files in this folder at the moment are named according to the followign convention: `out_` + number of MLIR modules in the file + `.mlir`.