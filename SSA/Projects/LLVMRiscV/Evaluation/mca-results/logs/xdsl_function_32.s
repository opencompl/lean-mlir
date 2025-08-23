/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_32.s:1:16: error: unknown operand
builtin.module {
               ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_32.s:2:19: error: unknown operand
  riscv_func.func @main(%0 : !riscv.reg<t0>, %1 : !riscv.reg<t1>) -> !riscv.reg {
                  ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_32.s:3:5: error: unexpected token at start of statement
    %2 = riscv.remu %0, %1 : (!riscv.reg<t0>, !riscv.reg<t1>) -> !riscv.reg<t0>
    ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_32.s:4:24: error: expected '%' relocation specifier
    riscv_func.return %2 : !riscv.reg<t0>
                       ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_32.s:4:24: error: unknown operand
    riscv_func.return %2 : !riscv.reg<t0>
                       ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_32.s:5:3: error: unexpected token at start of statement
  }
  ^
/home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/function_32.s:6:1: error: unexpected token at start of statement
}
^
error: Assembly input parsing had errors, use -skip-unsupported-instructions=parse-failure to drop failing lines from the input.
