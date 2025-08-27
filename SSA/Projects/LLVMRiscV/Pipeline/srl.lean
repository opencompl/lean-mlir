import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.srl` instruction for types: i32, i64.
-/

/-! ### i32 -/

@[simp_denote]
def lshr_llvm_no_flag_32 := [LV| {
  ^entry (%x: i32, %amount: i32):
    %1 = llvm.lshr %x, %amount : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def srl_riscv_32 := [LV| {
  ^entry (%x: i32, %amount: i32):
    %base = "builtin.unrealized_conversion_cast"(%x) : (i32) -> (!i64)
    %shamt = "builtin.unrealized_conversion_cast"(%amount) : (i32) -> (!i64)
    %res = srl %base, %shamt : !i64
    %y= "builtin.unrealized_conversion_cast"(%res) : (!i64) -> (i32)
    llvm.return %y : i32
  }]

-- @[simp_denote]
-- def llvm_srl_lower_riscv_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
--   lhs := lshr_llvm_no_flag_32
--   rhs := srl_riscv_32
--   correct := sorry

@[simp_denote]
def lshr_llvm_exact_32 := [LV| {
  ^entry (%x: i32, %amount: i32):
    %1 = llvm.lshr exact %x, %amount : i32
    llvm.return %1 : i32
  }]

-- def llvm_srl_lower_riscv_exact_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
--   lhs := lshr_llvm_exact_32
--   rhs := srl_riscv_32
--   correct := sorry


/-! ### i64 -/

@[simp_denote]
def lshr_llvm_no_flag_64 := [LV| {
  ^entry (%x: i64, %amount: i64):
    %1 = llvm.lshr %x, %amount : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def srl_riscv_64 := [LV| {
  ^entry (%x: i64, %amount: i64):
    %base = "builtin.unrealized_conversion_cast"(%x) : (i64) -> (!i64)
    %shamt = "builtin.unrealized_conversion_cast"(%amount) : (i64) -> (!i64)
    %res = srl %base, %shamt : !i64
    %y= "builtin.unrealized_conversion_cast"(%res) : (!i64) -> (i64)
    llvm.return %y : i64
  }]

@[simp_denote]
def llvm_srl_lower_riscv_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := lshr_llvm_no_flag_64
  rhs := srl_riscv_64

@[simp_denote]
def lshr_llvm_exact_64 := [LV| {
  ^entry (%x: i64, %amount: i64):
    %1 = llvm.lshr exact %x, %amount : i64
    llvm.return %1 : i64
  }]

def llvm_srl_lower_riscv_exact_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := lshr_llvm_exact_64
  rhs := srl_riscv_64

def srl_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  -- mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_srl_lower_riscv_exact_32),
  -- mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_srl_lower_riscv_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_srl_lower_riscv_exact_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_srl_lower_riscv_64),
]
