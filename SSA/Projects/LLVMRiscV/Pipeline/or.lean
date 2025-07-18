import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV


/-- This file contains lowering of the llvm or instruction -/

/- # OR non-disjoint  -/
@[simp_denote]
def or_llvm_noflag := [LV| {
    ^entry (%x: i64, %y: i64):
    %0 = llvm.or %x, %y : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
def or_riscv := [LV| {
    ^entry (%r1: i64, %r2: i64):
      %0 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> (!i64)
      %2 = or %0, %1 : !i64
      %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def llvm_or_lower_riscv_noflag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := or_llvm_noflag
  rhs := or_riscv


/-! # OR disjoint-/
/- The disjoint flag requries that no two bits at the same index are set in either of the bit vectors.
This allows an or to be treated as an addition.  -/
@[simp_denote]
def or_llvm_disjoint := [LV| {
    ^entry (%x: i64, %y: i64 ):
    %1 = llvm.or disjoint %x, %y : i64
    llvm.return %1 : i64
  }]

def llvm_or_lower_riscv_disjoint : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := or_llvm_disjoint
  rhs := or_riscv

def or_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
    [llvm_or_lower_riscv_noflag, llvm_or_lower_riscv_disjoint]
