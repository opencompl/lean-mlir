import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
import SSA.Projects.LLVMRiscV.Pipeline.icmp

open LLVMRiscV

/-!
  This file implements the lowering patterns that use pseudo-instructions by default.
  The implementations here do not use pseudo-instructions, but directly implements patterns
  in terms of the architectural instructions.
  For each pattern we only redefine the lowering, the source language pattern stays the same.

-/

/-! ### i32 -/

@[simp_denote]
def icmp_ne_riscv_32_no_pseudo := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = xor    %lhsr, %rhsr : !i64
    %c0 = li (0) : !i64
    %1 = sltu %c0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

@[simp_denote]
def icmp_eq_riscv_32_no_pseudo := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = xor    %lhsr, %rhsr : !i64
    %1 = sltiu %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_ne_riscv_eq_icmp_ne_llvm_32_no_pseudo : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_neq_llvm_32, rhs:= icmp_ne_riscv_32_no_pseudo}

def icmp_eq_riscv_eq_icmp_eq_llvm_32_no_pseudo : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_eq_llvm_32, rhs:= icmp_eq_riscv_32_no_pseudo}


/-! ### i64 -/

@[simp_denote]
def icmp_eq_riscv_64_no_pseudo := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = xor    %lhsr, %rhsr : !i64
    %1 = sltiu %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_eq_riscv_eq_icmp_eq_llvm_64_pseudo : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_eq_llvm_64, rhs:= icmp_eq_riscv_64_no_pseudo}


@[simp_denote]
def icmp_neq_riscv_64_no_pseudo := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = xor    %lhsr, %rhsr : !i64
    %c0 = li (0) : !i64
    %1 = sltu %c0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_ne_riscv_eq_icmp_ne_llvm_64_pseudo : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_neq_llvm_64, rhs:= icmp_neq_riscv_64_no_pseudo}

def pseudo_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
   mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_eq_riscv_eq_icmp_eq_llvm_64_pseudo),
   mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_ne_riscv_eq_icmp_ne_llvm_64_pseudo),
   mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_eq_riscv_eq_icmp_eq_llvm_32_pseudo),
   mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND icmp_ne_riscv_eq_icmp_ne_llvm_32_pseudo),
]
