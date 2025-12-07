# Benchmarks Generation 

### Dependencies 

This evaluation relies on dependencies from both `Evaluation/benchmarks` and `Evaluation/mca-analysis`. Therefore `llc` and `evallib` must be in the path. Evallib is added to the path in the given `run_comparison.sh` script.

### How to run

Use the `run_comparison.sh` script to run the comparisons. First make the script executable by:

```bash
chmod +x ./run_comparison.sh
```

Then run the script by:
```bash
./run_comparison.sh
```

The results are logged in the `comparison.log` file. 

### Results
The comparison script performs a comprehensive analysis of instruction lowering patterns across multiple compilers and optimization levels, organized into three distinct phases.

Phase 1: LLVM Compiler Consistency Check
    The script begins by comparing SelectionDAG and GlobalISel. For each instruction variant, it examines all optimization levels (O0, O1, O2, O3) to verify consistency within each compiler. This internal consistency check ensures that the instruction lowering pattern remains stable across different optimization levels within the same compiler backend.
Phase 2: Cross-Compiler Comparison (LLVM)
    After that, the script performs a cross-compiler comparison between SelectionDAG and GlobalISel outputs. For each optimization level, it compares the generated instruction sequences from both frameworks. This comparison reveals whether the two instruction selection approaches produce identical or different lowering patterns for the same input.
Phase 3: LEAN-MLIR vs LLVM Comparison
    Finally, the script compares the LEAN-MLIR compiler outputs against LLVM's results at specific optimization levels. This comparison is performed in two stages:

Unoptimized comparison: LEAN-MLIR output is compared against O0 outputs from both GlobalISel and SelectionDAG. 
Optimized comparison: LEAN-MLIR-opt output is compared against O2 outputs from both GlobalISel and SelectionDAG.
