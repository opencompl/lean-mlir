/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_8.s:1:16: error: unknown operand
builtin.module {
               ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_8.s:2:19: error: unknown operand
  riscv_func.func @main(%0 : !riscv.reg<t0>) -> !riscv.reg {
                  ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_8.s:3:24: error: expected '%' relocation specifier
    riscv_func.return %0 : !riscv.reg<t0>
                       ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_8.s:3:24: error: unknown operand
    riscv_func.return %0 : !riscv.reg<t0>
                       ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_8.s:4:3: error: unexpected token at start of statement
  }
  ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_8.s:5:1: error: unexpected token at start of statement
}
^
error: Assembly input parsing had errors, use -skip-unsupported-instructions=parse-failure to drop failing lines from the input.
