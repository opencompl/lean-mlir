import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/- # AND -/
@[simp_denote]
def and_llvm := [LV| {
  ^entry (%lhs: i64, %rhs: i64 ):
  %1 = llvm.and %lhs, %rhs : i64
  llvm.return %1 : i64
  }]

@[simp_denote]
def and_riscv := [LV| {
  ^entry (%lhs: i64, %rhs: i64 ):
  %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i64) -> (!i64)
  %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i64) -> (!i64)
  %0 = and %lhsr, %rhsr : !i64
  %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
  llvm.return %1 : i64
  }]

def llvm_and_lower_riscv : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= and_llvm
  rhs:= and_riscv

def and_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_and_lower_riscv]
