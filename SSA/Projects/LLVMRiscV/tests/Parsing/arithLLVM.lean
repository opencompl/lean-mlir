
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
open LLVMRiscV

def sdiv_llvm_no_exact := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.sdiv %x, %y : i64
    llvm.return %1 : i64
  }]

def sdiv_riscv := [LV| {
    ^entry (%0: i64, %1: i64):
  %2 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!i64)
  %3 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!i64)
  %4 = "riscv.add"(%2, %3) : (i64, i64) -> (i64)
  %5 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!i64)
  %6 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!i64)
  %7 = "riscv.add"(%5, %6) : (i64, i64) -> (i64)
  %8 = "riscv.add"(%4, %7) : (i64, i64) -> (i64)
  %9 = "builtin.unrealized_conversion_cast"(%8) : (i64) -> (i64)
    llvm.return %9 : i64
  }]

def llvm_sdiv_lower_riscv_no_flag: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := sdiv_llvm_no_exact
  rhs := sdiv_riscv
  correct := by
    unfold sdiv_llvm_no_exact sdiv_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    by_cases onX2 : x' = 0#64 <;> simp [onX2]
