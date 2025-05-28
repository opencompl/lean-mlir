import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

open LLVMRiscV

-- this implements the function that was wrongly compiled for the AARCH64 backend 
def riscv_lowering := [LV| {
  ^entry (%lhs: i32 ):
  %a1 = "builtin.unrealized_conversion_cast" (%lhs) : (i32) -> (!i64)
  %0 = lui %a1, 371148 : !i64
  %4 = "addiw" (%0) { imm = -1420 : !i64 } : (!i64) -> (!i64)
  %2 = and %a1, %4 : !i64
  %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
  llvm.return %3 : i32
  }]


def llvm := [LV| {
  ^entry (%lhs: i32 ):
  %a0 = llvm.mlir.constant(65536 : i32) : i32
  %a1 = llvm.or %lhs, %a0 : i32
  %a2 = llvm.mlir.constant(1520220788 : i32) : i32
  %2 = llvm.and %a1, %a2 : i32
  llvm.return %2 : i32
  }]

  def llvm_and_lower_riscv : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs:= llvm
  rhs:= riscv_lowering
  correct := by
    unfold llvm riscv_lowering
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
