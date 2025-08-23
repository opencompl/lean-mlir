/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_24.s:1:16: error: unknown operand
builtin.module {
               ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_24.s:2:19: error: unknown operand
  riscv_func.func @main(%0 : !riscv.reg<t1>) -> !riscv.reg {
                  ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_24.s:3:5: error: unexpected token at start of statement
    %1 = riscv.div %0, %0 : (!riscv.reg<t1>, !riscv.reg<t1>) -> !riscv.reg<t0>
    ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_24.s:4:5: error: unexpected token at start of statement
    %2 = riscv.or %1, %0 : (!riscv.reg<t0>, !riscv.reg<t1>) -> !riscv.reg<t0>
    ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_24.s:5:24: error: expected '%' relocation specifier
    riscv_func.return %2 : !riscv.reg<t0>
                       ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_24.s:5:24: error: unknown operand
    riscv_func.return %2 : !riscv.reg<t0>
                       ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_24.s:6:3: error: unexpected token at start of statement
  }
  ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_24.s:7:1: error: unexpected token at start of statement
}
^
error: Assembly input parsing had errors, use -skip-unsupported-instructions=parse-failure to drop failing lines from the input.
