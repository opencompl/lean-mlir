import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.sdiv` instruction for types i32, i64.
-/

/-! ### i32  -/

@[simp_denote]
def sdiv_llvm_no_exact_32 := [LV| {
  ^entry (%x: i32, %y: i32):
    %1 = llvm.sdiv %x, %y : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def sdiv_riscv_32 := [LV| {
  ^entry (%reg1: i32, %reg2: i32):
    %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i32) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i32) -> (!i64)
    %2 = div %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
    llvm.return %3 : i32
  }]

def llvm_sdiv_lower_riscv_no_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := sdiv_llvm_no_exact_32
  rhs := sdiv_riscv_32
  correct :=
  by
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    · sorry
    · sorry

@[simp_denote]
def sdiv_llvm_exact_32 := [LV| {
  ^entry (%x: i32, %y: i32):
    %1 = llvm.sdiv exact %x, %y : i32
    llvm.return %1 : i32
  }]

def llvm_sdiv_lower_riscv_exact_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := sdiv_llvm_exact_32
  rhs := sdiv_riscv_32
  correct := sorry

/-! ### i64 -/

@[simp_denote]
def sdiv_llvm_no_exact_64 := [LV| {
  ^entry (%x: i64, %y: i64):
    %1 = llvm.sdiv %x, %y : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def sdiv_riscv_64 := [LV| {
  ^entry (%reg1: i64, %reg2: i64):
    %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i64) -> (!i64)
    %2 = div %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_sdiv_lower_riscv_no_flag_64: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := sdiv_llvm_no_exact_64
  rhs := sdiv_riscv_64

@[simp_denote]
def sdiv_llvm_exact_64 := [LV| {
  ^entry (%x: i64, %y: i64 ):
    %1 = llvm.sdiv exact %x, %y : i64
    llvm.return %1 : i64
  }]

def llvm_sdiv_lower_riscv_exact_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := sdiv_llvm_exact_64
  rhs := sdiv_riscv_64

def sdiv_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sdiv_lower_riscv_exact_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sdiv_lower_riscv_no_flag_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sdiv_lower_riscv_exact_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sdiv_lower_riscv_no_flag_64)
]
