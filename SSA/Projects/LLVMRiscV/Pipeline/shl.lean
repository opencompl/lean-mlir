import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-! # SHL (shift left) nsw nuw -/

@[simp_denote]
def shl_llvm := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl %x, %y : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def shl_llvm_nsw := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl %x, %y overflow<nsw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def shl_llvm_nuw := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl %x, %y overflow<nuw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def shl_llvm_nsw_nuw := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl  %x, %y overflow<nsw,nuw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def shl_riscv := [LV| {
    ^entry (%reg1: i64, %reg2: i64 ):
    %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i64) -> (!i64)
    %2 = sll %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

@[simp_denote]
def llvm_shl_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm
  rhs := shl_riscv


def llvm_shl_lower_riscv_nsw: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm_nsw
  rhs := shl_riscv

def llvm_shl_lower_riscv_nuw: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm_nuw
  rhs := shl_riscv

def llvm_shl_lower_riscv_nsw_nuw: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm_nsw_nuw
  rhs := shl_riscv

def shl_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_shl_lower_riscv, llvm_shl_lower_riscv_nsw, llvm_shl_lower_riscv_nsw_nuw, llvm_shl_lower_riscv_nuw]
