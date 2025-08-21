## Organization of the folder 
- `LLVMAndRiscv.lean` contains the hybrid dialect that we need to apply the ISel pass/rewrites
- `ParseAndTransform.lean` contains the infra to parse an input file into the hybrid dialect
- `PeepholeRefine.lean` contains the definitions of the peephole rewrite structures for LLVM and RV64 and the infra to pass the hybrid-dialect-based rewrites to the peephoole rewriter, sorrying the proof that the rewriter requires given refinement is not yet supported.
- `simpproc.lean` contains the `simp` procedure we apply to the hybrid dialect to remove infra overhead


### `tests` folder: 

1. translate LLVM IR to MLIR: `mlir-translate -import-llvm "$INPUT_FILE"`
2. optimize: `mlir-opt --mlir-print-op-generic "$INPUT_FILE"`
3. extract the first basic block: `extractbb0.sh $INPUT_FILE > ${OUT_MLIR}`
4. `lake exe opt --passriscv64 SSA/Projects/LLVMRiscV/tests/LLVMIR/${OUT_MLIR} > SSA/Projects/LLVMRiscV/tests/LLVMIR/${OUT1_MLIR}`
