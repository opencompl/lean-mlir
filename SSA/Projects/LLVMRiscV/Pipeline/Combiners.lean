import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
import SSA.Projects.LLVMRiscV.Pipeline.ConstantMatching
import SSA.Projects.LLVMRiscV.Pipeline.MIRCombines

open LLVMRiscV

/- This file implements `DAGCombiner` patterns extracted from the LLVM Risc-V backend.
  First, we implement the Lean structure that implements the rewrite patterns and then we implement
  optimizations for LLVM IR and RISC-V.
  In particular, we implement the patterns supported by LLVM's `GlobalIsel` for RISC-V.
  Because `GlobalIsel` is hybrid, some of these patterns regard generic IR,
  while some are target-dependent.
-/

/-!
  # Post-legalization optimizations

  We implement post-legalization optimizations from LLVM's `GlobalISel` instructor selector.
  Our naming conventions are consistent with the RISC-V backend.

  We do not support known-bits analysis nor matching on values, and therefore do not implement the
  patterns relying on this infrastructure (e.g., `shift_immed_chain`).
-/

/-- ### select_same_val
  (cond ? x : x) → x
-/
def select_same_val_self : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1), Ty.llvm (.bitvec 64) ] where
  lhs := [LV| {
    ^entry (%x: i64, %c: i1):
      %0 = llvm.select %c, %x, %x : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %c: i1):
      llvm.return %x : i64
  }]

def select_same_val : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
  [⟨_, select_same_val_self⟩]

/-! ### select_constant_cmp -/

/-
Test the rewrite:
  (true ? x : y) -> x
  (false ? x : y) -> y
-/
def select_constant_cmp_true : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.mlir.constant (1) : i1
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      llvm.return %x : i64
  }]

def select_constant_cmp_false : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.mlir.constant (0) : i1
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      llvm.return %y : i64
  }]

def select_constant_cmp : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
  [⟨_, select_constant_cmp_true⟩,
  ⟨_, select_constant_cmp_false⟩]

/-- ### right_identity_zero
  (x op 0) → x
-/

def right_identity_zero_rol : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (0) : !riscv.reg
      %0 = rol %x, %c : !riscv.reg
      ret %0 : !riscv.reg
  }]
  rhs := [LV| {
    ^entry (%x: !riscv.reg):
      ret %x : !riscv.reg
  }]

def right_identity_zero_ror : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (0) : !riscv.reg
      %0 = ror %x, %c : !riscv.reg
      ret %0 : !riscv.reg
  }]
  rhs := [LV| {
    ^entry (%x: !riscv.reg):
      ret %x : !riscv.reg
  }]

/-- the whole `right_identity_zero` comprises the patterns for all the operations. -/
def right_identity_zero : List (Σ Γ, RISCVPeepholeRewrite  Γ) :=
  [⟨_, right_identity_zero_rol⟩,
  ⟨_, right_identity_zero_ror ⟩]

/-! ### hoist_logic_op_with_same_opcode_hands -/

/-
Test the rewrite:
 fold (sext(X) & sext(Y)) -> sext(X & Y)
-/
def AndSextSext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.sext %x : i32 to i64
      %1 = llvm.sext %y : i32 to i64
      %2 = llvm.and %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.and %x, %y : i32
      %1 = llvm.sext %0 : i32 to i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold (sext(X) | sext(Y)) -> sext(X | Y)
-/
def OrSextSext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.sext %x : i32 to i64
      %1 = llvm.sext %y : i32 to i64
      %2 = llvm.or %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.or %x, %y : i32
      %1 = llvm.sext %0 : i32 to i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold (sext(X) ^ sext(Y)) -> sext(X ^ Y)
-/
def XorSextSext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.sext %x : i32 to i64
      %1 = llvm.sext %y : i32 to i64
      %2 = llvm.xor %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.xor %x, %y : i32
      %1 = llvm.sext %0 : i32 to i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold (zext(X) & zext(Y)) -> zext(X & Y)
-/
def AndZextZext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.zext %x : i32 to i64
      %1 = llvm.zext %y : i32 to i64
      %2 = llvm.and %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.and %x, %y : i32
      %1 = llvm.zext %0 : i32 to i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold (zext(X) | zext(Y)) -> zext(X | Y)
-/
def OrZextZext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.zext %x : i32 to i64
      %1 = llvm.zext %y : i32 to i64
      %2 = llvm.or %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.or %x, %y : i32
      %1 = llvm.zext %0 : i32 to i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold (zext(X) ^ zext(Y)) -> zext(X ^ Y)
-/
def XorZextZext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.zext %x : i32 to i64
      %1 = llvm.zext %y : i32 to i64
      %2 = llvm.xor %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32, %y: i32):
      %0 = llvm.xor %x, %y : i32
      %1 = llvm.zext %0 : i32 to i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold (trunc(X) & trunc(Y)) -> trunc(X & Y)
-/
def AndTruncTrunc : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.trunc %x : i64 to i32
      %1 = llvm.trunc %y : i64 to i32
      %2 = llvm.and %0, %1 : i32
      llvm.return %2 : i32
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.and %x, %y : i64
      %1 = llvm.trunc %0 : i64 to i32
      llvm.return %1 : i32
  }]

/-
Test the rewrite:
 fold (trunc(X) | trunc(Y)) -> trunc(X | Y)
-/
def OrTruncTrunc : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.trunc %x : i64 to i32
      %1 = llvm.trunc %y : i64 to i32
      %2 = llvm.or %0, %1 : i32
      llvm.return %2 : i32
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.or %x, %y : i64
      %1 = llvm.trunc %0 : i64 to i32
      llvm.return %1 : i32
  }]

/-
Test the rewrite:
 fold (trunc(X) ^ trunc(Y)) -> trunc(X ^ Y)
-/
def XorTruncTrunc : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.trunc %x : i64 to i32
      %1 = llvm.trunc %y : i64 to i32
      %2 = llvm.xor %0, %1 : i32
      llvm.return %2 : i32
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.xor %x, %y : i64
      %1 = llvm.trunc %0 : i64 to i32
      llvm.return %1 : i32
  }]

/-
Test the rewrite:
 fold ((X << Z) & (Y << Z)) -> (X & Y) << Z
-/
def AndShlShl : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.shl %x, %z : i64
      %1 = llvm.shl %y, %z : i64
      %2 = llvm.and %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.and %x, %y : i64
      %1 = llvm.shl %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X << Z) | (Y << Z)) -> (X | Y) << Z
-/
def OrShlShl : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.shl %x, %z : i64
      %1 = llvm.shl %y, %z : i64
      %2 = llvm.or %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.or %x, %y : i64
      %1 = llvm.shl %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X << Z) ^ (Y << Z)) -> (X ^ Y) << Z
-/
def XorShlShl : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.shl %x, %z : i64
      %1 = llvm.shl %y, %z : i64
      %2 = llvm.xor %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.xor %x, %y : i64
      %1 = llvm.shl %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X >> Z) & (Y >> Z)) -> (X & Y) >> Z (logical shift)
-/
def AndLshrLshr : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.lshr %x, %z : i64
      %1 = llvm.lshr %y, %z : i64
      %2 = llvm.and %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.and %x, %y : i64
      %1 = llvm.lshr %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X >> Z) | (Y >> Z)) -> (X | Y) >> Z (logical shift)
-/
def OrLshrLshr : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.lshr %x, %z : i64
      %1 = llvm.lshr %y, %z : i64
      %2 = llvm.or %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.or %x, %y : i64
      %1 = llvm.lshr %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X >> Z) ^ (Y >> Z)) -> (X ^ Y) >> Z (logical shift)
-/
def XorLshrLshr : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.lshr %x, %z : i64
      %1 = llvm.lshr %y, %z : i64
      %2 = llvm.xor %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.xor %x, %y : i64
      %1 = llvm.lshr %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X >> Z) & (Y >> Z)) -> (X & Y) >> Z (arithmetic shift)
-/
def AndAshrAshr : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.ashr %x, %z : i64
      %1 = llvm.ashr %y, %z : i64
      %2 = llvm.and %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.and %x, %y : i64
      %1 = llvm.ashr %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X >> Z) | (Y >> Z)) -> (X | Y) >> Z (arithmetic shift)
-/
def OrAshrAshr : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.ashr %x, %z : i64
      %1 = llvm.ashr %y, %z : i64
      %2 = llvm.or %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.or %x, %y : i64
      %1 = llvm.ashr %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X >> Z) ^ (Y >> Z)) -> (X ^ Y) >> Z (arithmetic shift)
-/
def XorAshrAshr : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.ashr %x, %z : i64
      %1 = llvm.ashr %y, %z : i64
      %2 = llvm.xor %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.xor %x, %y : i64
      %1 = llvm.ashr %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X & Z) & (Y & Z)) -> (X & Y) & Z
-/
def AndAndAnd : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.and %x, %z : i64
      %1 = llvm.and %y, %z : i64
      %2 = llvm.and %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.and %x, %y : i64
      %1 = llvm.and %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X & Z) | (Y & Z)) -> (X | Y) & Z
-/
def OrAndAnd : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.and %x, %z : i64
      %1 = llvm.and %y, %z : i64
      %2 = llvm.or %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.or %x, %y : i64
      %1 = llvm.and %0, %z : i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
 fold ((X & Z) ^ (Y & Z)) -> (X ^ Y) & Z
-/
def XorAndAnd : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.and %x, %z : i64
      %1 = llvm.and %y, %z : i64
      %2 = llvm.xor %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64, %z: i64):
      %0 = llvm.xor %x, %y : i64
      %1 = llvm.and %0, %z : i64
      llvm.return %1 : i64
  }]

def hoist_logic_op_with_same_opcode_hands_32 : List (Σ Γ, LLVMPeepholeRewriteRefine 32 Γ) :=
  [⟨_, AndTruncTrunc⟩,
  ⟨_, OrTruncTrunc⟩,
  ⟨_, XorTruncTrunc⟩]

def hoist_logic_op_with_same_opcode_hands_64 : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, AndSextSext⟩,
  ⟨_, OrSextSext⟩,
  ⟨_, XorSextSext⟩,
  ⟨_, AndZextZext⟩,
  ⟨_, OrZextZext⟩,
  ⟨_, XorZextZext⟩,
  ⟨_, AndShlShl⟩,
  ⟨_, OrShlShl⟩,
  ⟨_, XorShlShl⟩,
  ⟨_, AndLshrLshr⟩,
  ⟨_, OrLshrLshr⟩,
  ⟨_, XorLshrLshr⟩,
  ⟨_, AndAshrAshr⟩,
  ⟨_, OrAshrAshr⟩,
  ⟨_, XorAshrAshr⟩,
  ⟨_, AndAndAnd⟩,
  ⟨_, OrAndAnd⟩,
  ⟨_, XorAndAnd⟩]


/-! ### select_to_iminmax -/

/-
Test the rewrite:
 (icmp X, Y) ? X : Y -> integer minmax.
-/
def select_to_iminmax_ugt : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.ugt %x, %y : i64
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast" (%y) : (i64) -> (!i64)
      %2 =  maxu %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def select_to_iminmax_uge : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.uge %x, %y : i64
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast" (%y) : (i64) -> (!i64)
      %2 =  maxu %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def select_to_iminmax_sgt : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.sgt %x, %y : i64
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast" (%y) : (i64) -> (!i64)
      %2 =  max %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def select_to_iminmax_sge : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.sgt %x, %y : i64
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast" (%y) : (i64) -> (!i64)
      %2 =  max %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def select_to_iminmax_ult : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.ult %x, %y : i64
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast" (%y) : (i64) -> (!i64)
      %2 =  minu %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def select_to_iminmax_ule : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.ule %x, %y : i64
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast" (%y) : (i64) -> (!i64)
      %2 =  minu %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def select_to_iminmax_slt : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.slt %x, %y : i64
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast" (%y) : (i64) -> (!i64)
      %2 =  min %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def select_to_iminmax_sle : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.sle %x, %y : i64
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast" (%y) : (i64) -> (!i64)
      %2 =  min %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def select_to_iminmax: List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, select_to_iminmax_ugt⟩,
  ⟨_, select_to_iminmax_uge⟩,
  ⟨_, select_to_iminmax_sgt⟩,
  ⟨_, select_to_iminmax_sge⟩,
  ⟨_, select_to_iminmax_ult⟩,
  ⟨_, select_to_iminmax_ule⟩,
  ⟨_, select_to_iminmax_slt⟩,
  ⟨_, select_to_iminmax_sle⟩
  ]

/-! ### cast_of_cast_combines -/

/-
Test the rewrite:
  Transform trunc ([asz]ext x) to x or ([asz]ext x) or (trunc x)
-/
def trunc_of_zext: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.zext %x: i32 to i64
      %1 = llvm.trunc %0: i64 to i32
      llvm.return %1 : i32
  }]
  rhs := [LV| {
    ^entry (%x: i32):
      llvm.return %x : i32
  }]

def trunc_of_zext_zext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.zext %x: i32 to i64
      %1 = llvm.trunc %0: i64 to i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.zext %x: i32 to i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
  Fold ([asz]ext ([asz]ext x)) -> ([asz]ext x)
-/
def zext_of_zext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.zext %x: i32 to i64
      %1 = llvm.zext %0: i64 to i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.zext %x: i32 to i64
      llvm.return %0 : i64
  }]

def sext_of_zext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.zext %x: i32 to i64
      %1 = llvm.sext %0: i64 to i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.zext %x: i32 to i64
      llvm.return %0 : i64
  }]

def sext_of_sext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.sext %x: i32 to i64
      %1 = llvm.sext %0: i64 to i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.sext %x: i32 to i64
      llvm.return %0 : i64
  }]

def zext_of_sext : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.sext %x: i32 to i64
      %1 = llvm.zext %0: i64 to i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.sext %x: i32 to i64
      llvm.return %0 : i64
  }]

def cast_of_cast_combines_64 : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, trunc_of_zext_zext⟩,
  ⟨_, zext_of_zext⟩,
  ⟨_, sext_of_zext⟩,
  ⟨_, sext_of_sext⟩,
  ⟨_, zext_of_sext⟩]

def cast_of_cast_combines_32 : List (Σ Γ, LLVMPeepholeRewriteRefine 32 Γ) :=
  [⟨_, trunc_of_zext⟩]


/-! ### sext_trunc -/

/-
Test the rewrite:
  Transform sext (trunc x) to x or (sext x), (trunc x) or x
-/

def sext_trunc : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.trunc %x: i64 to i32
      %1 = llvm.sext %0: i32 to i32
      llvm.return %1 : i32
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.trunc %x: i64 to i32
      llvm.return %0 : i32
  }]

def zext_trunc : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.trunc %x: i64 to i32
      %1 = llvm.zext %0: i32 to i32
      llvm.return %1 : i32
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.trunc %x: i64 to i32
      llvm.return %0 : i32
  }]

def sext_trunc_fold_32 : List (Σ Γ, LLVMPeepholeRewriteRefine 32 Γ) :=
  [⟨_, sext_trunc⟩,
  ⟨_, zext_trunc⟩]

/-- ### anyext_trunc_fold
  (anyext (trunc x)) → x
-/
def anyext_trunc_fold_sext_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.sext %x: i32 to i64
      %1 = llvm.trunc %0: i64 to i32
      llvm.return %1 : i32
  }]
  rhs := [LV| {
    ^entry (%x: i32):
      llvm.return %x : i32
  }]

def anyext_trunc_fold_zext_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := [LV| {
    ^entry (%x: i32):
      %0 = llvm.zext %x: i32 to i64
      %1 = llvm.trunc %0: i64 to i32
      llvm.return %1 : i32
  }]
  rhs := [LV| {
    ^entry (%x: i32):
      llvm.return %x : i32
  }]

/-- the whole `anyext_trunc_fold` patterns comprises both `sext` and `zext`. -/
def anyext_trunc_fold: List (Σ Γ, LLVMPeepholeRewriteRefine 32 Γ) :=
  [⟨_, anyext_trunc_fold_sext_32⟩,
  ⟨_, anyext_trunc_fold_zext_32⟩]

/-- ### simplify_neg_minmax
  (neg (min x (neg x))) → (max x (neg x))
  (neg (max x (neg x))) → (min x (neg x))
-/
def simplify_neg_minmax : RISCVPeepholeRewrite [Ty.riscv (.bv) ] where
  lhs := [LV| {
    ^entry (%x: !riscv.reg):
      %0 = neg %x : !riscv.reg
      %1 = min %x, %0 : !riscv.reg
      %2 = neg %1 : !riscv.reg
      ret %2 : !riscv.reg
  }]
  rhs := [LV| {
    ^entry (%x: !riscv.reg):
      %0 = neg %x : !riscv.reg
      %1 = max %x, %0 : !riscv.reg
      ret %1 : !riscv.reg
  }]

def simplify_neg_maxmin : RISCVPeepholeRewrite [Ty.riscv (.bv) ] where
  lhs := [LV| {
    ^entry (%x: !riscv.reg):
      %0 = neg %x : !riscv.reg
      %1 = max %x, %0 : !riscv.reg
      %2 = neg %1 : !riscv.reg
      ret %2 : !riscv.reg
  }]
  rhs := [LV| {
    ^entry (%x: !riscv.reg):
      %0 = neg %x : !riscv.reg
      %1 = min %x, %0 : !riscv.reg
      ret %1 : !riscv.reg
  }]

def simplify_neg : List (Σ Γ, RISCVPeepholeRewrite Γ) :=
  [⟨_, simplify_neg_minmax⟩,
  ⟨_, simplify_neg_maxmin⟩]

/-! ### select_of_zext -/

/-
Test the rewrite:
 fold zext(select(cond, true_val, false_val)) -> select(cond, zext(true_val), zext(false_val))
-/
def select_of_zext_rw : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%cond: i1, %true_val: i32, %false_val: i32):
      %0 = llvm.select %cond, %true_val, %false_val : i32
      %1 = llvm.zext %0 : i32 to i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%cond: i1, %true_val: i32, %false_val: i32):
      %0 = llvm.zext %true_val : i32 to i64
      %1 = llvm.zext %false_val : i32 to i64
      %2 = llvm.select %cond, %0, %1 : i64
      llvm.return %2 : i64
  }]

def select_of_zext : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, select_of_zext_rw⟩]

/-! ### select_of_anyext -/

/-
Test the rewrite:
 fold sext(select(cond, true_val, false_val)) -> select(cond, sext(true_val), sext(false_val))
-/
def select_of_anyext_rw : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%cond: i1, %true_val: i32, %false_val: i32):
      %0 = llvm.select %cond, %true_val, %false_val : i32
      %1 = llvm.sext %0 : i32 to i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%cond: i1, %true_val: i32, %false_val: i32):
      %0 = llvm.sext %true_val : i32 to i64
      %1 = llvm.sext %false_val : i32 to i64
      %2 = llvm.select %cond, %0, %1 : i64
      llvm.return %2 : i64
  }]

def select_of_anyext : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, select_of_anyext_rw⟩]

/-! ### select_of_truncate -/

/-
Test the rewrite:
 fold trunc(select(cond, true_val, false_val)) -> select(cond, trunc(true_val), trunc(false_val))
-/
def select_of_truncate_rw : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%cond: i1, %true_val: i64, %false_val: i64):
      %0 = llvm.select %cond, %true_val, %false_val : i64
      %1 = llvm.trunc %0 : i64 to i32
      llvm.return %1 : i32
  }]
  rhs := [LV| {
    ^entry (%cond: i1, %true_val: i64, %false_val: i64):
      %0 = llvm.trunc %true_val : i64 to i32
      %1 = llvm.trunc %false_val : i64 to i32
      %2 = llvm.select %cond, %0, %1 : i32
      llvm.return %2 : i32
  }]

def select_of_truncate : List (Σ Γ, LLVMPeepholeRewriteRefine 32 Γ) :=
  [⟨_, select_of_truncate_rw⟩]

/-! ### xor_of_and_with_same_reg -/

/-
Test the rewrite:
  Fold (xor (and x, y), y) -> (and (not x), y)
-/
def xor_of_and_with_same_reg : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.and %x, %y : i64
      %1 = llvm.xor %0, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.not %x : i64
      %1 = llvm.and %0, %y : i64
      llvm.return %1 : i64
  }]

def xor_of_and_with_same_reg_list : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, xor_of_and_with_same_reg⟩]


/-- ### commute_constant_to_rhs
  (C op x) → (x op C)
-/
  def commute_int_constant_to_rhs_add : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = add %c, %x : !riscv.reg
      ret %0 : !riscv.reg
  }]
  rhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = add %x, %c : !riscv.reg
      ret %0 : !riscv.reg
  }]

def commute_int_constant_to_rhs_mul : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = mul%c, %x : !riscv.reg
      ret %0 : !riscv.reg
  }]
  rhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = mul %x, %c : !riscv.reg
      ret %0 : !riscv.reg
  }]

def commute_int_constant_to_rhs_and : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = and %c, %x : !riscv.reg
      ret %0 : !riscv.reg
  }]
  rhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = and %x, %c : !riscv.reg
      ret %0 : !riscv.reg
  }]

def commute_int_constant_to_rhs_or : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = or %c, %x : !riscv.reg
      ret %0 : !riscv.reg
  }]
  rhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = or %x, %c : !riscv.reg
      ret %0 : !riscv.reg
  }]

def commute_int_constant_to_rhs_xor: RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = xor %c, %x : !riscv.reg
      ret %0 : !riscv.reg
  }]
  rhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = xor %x, %c : !riscv.reg
      ret %0 : !riscv.reg
  }]

def commute_int_constant_to_rhs_mulhu: RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = mulhu %c, %x : !riscv.reg
      ret %0 : !riscv.reg
  }]
  rhs := [LV| {
    ^entry (%x: !riscv.reg):
      %c = li (1) : !riscv.reg
      %0 = mulhu %x, %c : !riscv.reg
      ret %0 : !riscv.reg
  }]

def commute_int_constant_to_rhs: List (Σ Γ, RISCVPeepholeRewrite  Γ) :=
  [⟨_, commute_int_constant_to_rhs_add⟩,
  ⟨_, commute_int_constant_to_rhs_mul⟩,
  ⟨_, commute_int_constant_to_rhs_and⟩,
  ⟨_, commute_int_constant_to_rhs_or⟩,
  ⟨_, commute_int_constant_to_rhs_xor⟩,
  ⟨_, commute_int_constant_to_rhs_mulhu⟩]

/-! ### matchMulOBy2 -/

/-
Test the rewrite:
  (G_UMULO x, 2) -> (G_UADDO x, x)
  (G_SMULO x, 2) -> (G_SADDO x, x)
-/
def mulo_by_2_unsigned_signed : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (2) : i64
      %0 = llvm.mul %x, %c overflow<nsw, nuw> : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.add %x, %x overflow<nsw, nuw> : i64
      llvm.return %0 : i64
  }]

def mulo_by_2_unsigned : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (2) : i64
      %0 = llvm.mul %x, %c overflow<nuw> : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.add %x, %x overflow<nuw> : i64
      llvm.return %0 : i64
  }]

def mulo_by_2_signed : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (2) : i64
      %0 = llvm.mul %x, %c overflow<nsw> : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.add %x, %x overflow<nsw> : i64
      llvm.return %0 : i64
  }]


def matchMulO: List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, mulo_by_2_unsigned_signed⟩,
  ⟨_, mulo_by_2_unsigned⟩,
  ⟨_, mulo_by_2_signed⟩]

/-! ### sub_add_reg -/

/-
Test the rewrite:
  (x + y) - y -> x
-/
def sub_add_reg_x_add_y_sub_y : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %1 = llvm.add %x, %y : i64
      %2 = llvm.sub %1, %y : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      llvm.return %x : i64
  }]

/-
Test the rewrite:
  (x + y) - y -> x
-/
def sub_add_reg_x_add_y_sub_x : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %1 = llvm.add %x, %y : i64
      %2 = llvm.sub %1, %x : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      llvm.return %y : i64
  }]

/-
Test the rewrite:
  x - (y + x) -> 0 - y
-/
def sub_add_reg_x_sub_y_add_x : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %1 = llvm.add %y, %x : i64
      %2 = llvm.sub %x, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.sub %c, %y : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
  x - (x + y) -> 0 - y
-/
def sub_add_reg_x_sub_x_add_y : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %1 = llvm.add %x, %y : i64
      %2 = llvm.sub %x, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.sub %c, %y : i64
      llvm.return %0 : i64
  }]

def sub_add_reg : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, sub_add_reg_x_add_y_sub_y⟩,
  ⟨_, sub_add_reg_x_add_y_sub_x⟩,
  ⟨_, sub_add_reg_x_sub_y_add_x⟩,
  ⟨_, sub_add_reg_x_sub_x_add_y⟩]

/-! ### redundant_binop_in_equality -/

/-
Test the rewrite:
 fold ((X + Y) == X) -> (Y == 0)
-/
def redundant_binop_in_equality_XPlusYEqX : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.add %x, %y : i64
      %1 = llvm.icmp.eq %0, %x : i64
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.mlir.constant (0) : i64
      %1 = llvm.icmp.eq %y, %0 : i64
      llvm.return %1 : i1
  }]

/-
Test the rewrite:
 fold ((X + Y) != X) -> (Y != 0)
-/
def redundant_binop_in_equality_XPlusYNeX : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.add %x, %y : i64
      %1 = llvm.icmp.ne %0, %x : i64
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.mlir.constant (0) : i64
      %1 = llvm.icmp.ne %y, %0 : i64
      llvm.return %1 : i1
  }]

/-
Test the rewrite:
 fold ((X - Y) == X) -> (Y == 0)
-/
def redundant_binop_in_equality_XMinusYEqX : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.sub %x, %y : i64
      %1 = llvm.icmp.eq %0, %x : i64
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.mlir.constant (0) : i64
      %1 = llvm.icmp.eq %y, %0 : i64
      llvm.return %1 : i1
  }]

/-
Test the rewrite:
 fold ((X - Y) != X) -> (Y != 0)
-/
def redundant_binop_in_equality_XMinusYNeX : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.sub %x, %y : i64
      %1 = llvm.icmp.ne %0, %x : i64
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.mlir.constant (0) : i64
      %1 = llvm.icmp.ne %y, %0 : i64
      llvm.return %1 : i1
  }]

/-
Test the rewrite:
 fold ((X ^ Y) == X) -> (Y == 0)
-/
def redundant_binop_in_equality_XXorYEqX : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.xor %x, %y : i64
      %1 = llvm.icmp.eq %0, %x : i64
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.mlir.constant (0) : i64
      %1 = llvm.icmp.eq %y, %0 : i64
      llvm.return %1 : i1
  }]

/-
Test the rewrite:
 fold ((X ^ Y) != X) -> (Y != 0)
-/
def redundant_binop_in_equality_XXorYNeX : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.xor %x, %y : i64
      %1 = llvm.icmp.ne %0, %x : i64
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.mlir.constant (0) : i64
      %1 = llvm.icmp.ne %y, %0 : i64
      llvm.return %1 : i1
  }]

def redundant_binop_in_equality : List (Σ Γ, LLVMPeepholeRewriteRefine 1 Γ) :=
  [⟨_, redundant_binop_in_equality_XPlusYEqX⟩,
  ⟨_, redundant_binop_in_equality_XPlusYNeX⟩,
  ⟨_, redundant_binop_in_equality_XMinusYEqX⟩,
  ⟨_, redundant_binop_in_equality_XMinusYNeX⟩,
  ⟨_, redundant_binop_in_equality_XXorYEqX⟩,
  ⟨_, redundant_binop_in_equality_XXorYNeX⟩]

/-! ### match_selects -/

/-
Test the rewrite:
  select Cond, 1, 0 --> zext (Cond)
-/
def select_1_0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1):
      %t = llvm.mlir.constant (1) : i64
      %f = llvm.mlir.constant (0) : i64
      %0 = llvm.select %c, %t, %f : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1):
      %0 = llvm.zext %c: i1 to i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
  select Cond, -1, 0 --> sext (Cond)
-/
def select_neg1_0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1):
      %t = llvm.mlir.constant (-1) : i64
      %f = llvm.mlir.constant (0) : i64
      %0 = llvm.select %c, %t, %f : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1):
      %0 = llvm.sext %c: i1 to i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
  select Cond, 0, 1 --> zext (!Cond)
-/
def select_0_1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1):
      %t = llvm.mlir.constant (0) : i64
      %f = llvm.mlir.constant (1) : i64
      %0 = llvm.select %c, %t, %f : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1):
      %0 = llvm.not %c : i1
      %1 = llvm.zext %0: i1 to i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
  select Cond, 0, -1 --> sext (!Cond)
-/
def select_0_neg1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1):
      %t = llvm.mlir.constant (0) : i64
      %f = llvm.mlir.constant (-1) : i64
      %0 = llvm.select %c, %t, %f : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1):
      %0 = llvm.not %c : i1
      %1 = llvm.sext %0: i1 to i64
      llvm.return %1 : i64
  }]

/-
Test the rewrite:
  select Cond, Cond, F --> or Cond, F
-/
def select_cond_f : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1, %f : i64):
      %0 = llvm.sext %c: i1 to i64
      %1 = llvm.select %c, %0, %f : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1, %f: i64):
      %0 = llvm.sext %c: i1 to i64
      %1 = llvm.freeze %f : i64
      %2 = llvm.or %0, %1 : i64
      llvm.return %2 : i64
  }]

/-
Test the rewrite:
  select Cond, 1, F --> or Cond, F
-/
def select_1_f : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1, %f: i64):
      %c1 = llvm.mlir.constant (1) : i1
      %0 = llvm.sext %c1: i1 to i64
      %1 = llvm.select %c, %0, %f : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1, %f: i64):
      %0 = llvm.sext %c: i1 to i64
      %1 = llvm.freeze %f : i64
      %2 = llvm.or %0, %1 : i64
      llvm.return %2 : i64
  }]

/-
Test the rewrite:
  select Cond, T, Cond --> and Cond, T
-/
def select_t_cond : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1, %t: i64):
      %0 = llvm.sext %c: i1 to i64
      %1 = llvm.select %c, %t, %0 : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1, %t: i64):
      %0 = llvm.sext %c: i1 to i64
      %1 = llvm.freeze %t : i64
      %2 = llvm.and %0, %1 : i64
      llvm.return %2 : i64
  }]

/-
Test the rewrite:
  select Cond, T, 0 --> and Cond, T
-/
def select_t_0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1, %t: i64):
      %c0 = llvm.mlir.constant (0) : i64
      %0 = llvm.select %c, %t, %c0 : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1, %t: i64):
      %cext = llvm.sext %c: i1 to i64
      %tfreeze = llvm.freeze %t : i64
      %0 = llvm.and %cext, %tfreeze : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
  select Cond, T, 1 --> or (not Cond), T
-/
def select_t_1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1, %t: i64):
      %c1 = llvm.mlir.constant (1) : i1
      %0 = llvm.sext %c1: i1 to i64
      %1 = llvm.select %c, %t, %0 : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1, %t: i64):
      %0 = llvm.not %c : i1
      %1 = llvm.sext %0: i1 to i64
      %2 = llvm.freeze %t : i64
      %3 = llvm.or %1, %2 : i64
      llvm.return %3 : i64
  }]

/-
Test the rewrite:
  select Cond, 0, F --> and (not Cond), F
-/
def select_0_f : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1, %f: i64):
      %zero = llvm.mlir.constant (0) : i64
      %0 = llvm.select %c, %zero, %f : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1, %f: i64):
      %0 = llvm.not %c : i1
      %1 = llvm.sext %0: i1 to i64
      %2 = llvm.freeze %f : i64
      %3 = llvm.and %1, %2 : i64
      llvm.return %3 : i64
  }]

def match_selects : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
  [⟨_, select_1_0⟩,
  ⟨_, select_neg1_0⟩,
  ⟨_, select_0_1⟩,
  ⟨_, select_0_neg1⟩,
  ⟨_, select_cond_f⟩,
  ⟨_, select_1_f⟩,
  ⟨_, select_t_cond⟩,
  ⟨_, select_t_0⟩,
  ⟨_, select_t_1⟩,
  ⟨_, select_0_f⟩]

/-! ### add_shift -/

/-
Test the rewrite:
  fold (A+shl(0-B, C)) -> (A-shl(B, C))
-/
def add_shift : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %zero = llvm.mlir.constant (0) : i64
      %neg_b = llvm.sub %zero, %b : i64
      %shl_neg = llvm.shl %neg_b, %c : i64
      %result = llvm.add %a, %shl_neg : i64
      llvm.return %result : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %new_shl = llvm.shl %b, %c : i64
      %result = llvm.sub %a, %new_shl : i64
      llvm.return %result : i64
  }]

def add_shift_commute : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %zero = llvm.mlir.constant (0) : i64
      %neg_b = llvm.sub %zero, %b : i64
      %shl_neg = llvm.shl %neg_b, %c : i64
      %result = llvm.add %shl_neg, %a : i64
      llvm.return %result : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %new_shl = llvm.shl %b, %c : i64
      %result = llvm.sub %a, %new_shl : i64
      llvm.return %result : i64
  }]

def add_shift_rw : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, add_shift⟩,
   ⟨_, add_shift_commute⟩]

/- ### not_cmp_fold
  (a op b) ^^^ (-1) → (a op' b) where op' is the inverse of op
-/
def not_cmp_fold_eq : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.eq %x, %y : i64
      %c = llvm.mlir.constant (-1) : i1
      %1 = llvm.xor %0, %c : i1
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.ne %x, %y : i64
      llvm.return %0 : i1
  }]

def not_cmp_fold_ne : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.ne %x, %y : i64
      %c = llvm.mlir.constant (-1) : i1
      %1 = llvm.xor %0, %c : i1
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.eq %x, %y : i64
      llvm.return %0 : i1
  }]

def not_cmp_fold_ge : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.ne %x, %y : i64
      %c = llvm.mlir.constant (-1) : i1
      %1 = llvm.xor %0, %c : i1
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.eq %x, %y : i64
      llvm.return %0 : i1
  }]

def not_cmp_fold_ugt : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.ugt %x, %y : i64
      %c = llvm.mlir.constant (-1) : i1
      %1 = llvm.xor %0, %c : i1
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.ule %x, %y : i64
      llvm.return %0 : i1
  }]

def not_cmp_fold_uge : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.uge %x, %y : i64
      %c = llvm.mlir.constant (-1) : i1
      %1 = llvm.xor %0, %c : i1
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.ult %x, %y : i64
      llvm.return %0 : i1
  }]

def not_cmp_fold_sgt : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.sgt %x, %y : i64
      %c = llvm.mlir.constant (-1) : i1
      %1 = llvm.xor %0, %c : i1
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.sle %x, %y : i64
      llvm.return %0 : i1
  }]

def not_cmp_fold_sge : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.sge %x, %y : i64
      %c = llvm.mlir.constant (-1) : i1
      %1 = llvm.xor %0, %c : i1
      llvm.return %1 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.icmp.slt %x, %y : i64
      llvm.return %0 : i1
  }]


def not_cmp_fold : List (Σ Γ, LLVMPeepholeRewriteRefine 1 Γ) :=
  [⟨_, not_cmp_fold_eq⟩,
  ⟨_, not_cmp_fold_ne⟩,
  ⟨_, not_cmp_fold_ge⟩,
  ⟨_, not_cmp_fold_ugt⟩,
  ⟨_, not_cmp_fold_uge⟩,
  ⟨_, not_cmp_fold_sgt⟩,
  ⟨_, not_cmp_fold_sge⟩,
  ⟨_, not_cmp_fold_sge⟩]

/-! ### double_icmp_zero_combine -/

/-
Test the rewrite:
  Transform: (X == 0 & Y == 0) -> (X | Y) == 0
-/
def double_icmp_zero_and_combine : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.icmp.eq %x, %c : i64
      %1 = llvm.icmp.eq %y, %c : i64
      %2 = llvm.and %0, %1 : i1
      llvm.return %2 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.or %x, %y : i64
      %1 = llvm.icmp.eq %0, %c : i64
      llvm.return %1 : i1
  }]

/-
Test the rewrite:
  Transform: (X != 0 & Y != 0) -> (X | Y) != 0
-/
def double_icmp_zero_or_combine : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.icmp.ne %x, %c : i64
      %1 = llvm.icmp.ne %y, %c : i64
      %2 = llvm.or %0, %1 : i1
      llvm.return %2 : i1
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.or %x, %y : i64
      %1 = llvm.icmp.ne %0, %c : i64
      llvm.return %1 : i1
  }]

def double_icmp_zero_combine : List (Σ Γ, LLVMPeepholeRewriteRefine 1 Γ) :=
  [⟨_, double_icmp_zero_and_combine⟩,
  ⟨_, double_icmp_zero_or_combine⟩]

 /-! ### Grouped patterns -/

/-- We assemble the `identity_combines` patterns for RISCV as in GlobalISel -/
def RISCV_identity_combines: List (Σ Γ, RISCVPeepholeRewrite Γ) :=
  right_identity_zero

/-- We assemble the `identity_combines` patterns for LLVM as in GlobalISel -/
def LLVMIR_identity_combines_64 : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  select_same_val ++
  select_constant_cmp ++ urem_pow2_to_mask

def LLVMIR_identity_combines_32 : List (Σ Γ, LLVMPeepholeRewriteRefine 32 Γ) := anyext_trunc_fold

def LLVMIR_cast_combines_64 : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  select_of_zext ++ select_of_anyext

def LLVMIR_cast_combines_32 : List (Σ Γ, LLVMPeepholeRewriteRefine 32 Γ) := select_of_truncate

/-- Post-legalization combine pass for RISCV -/
def PostLegalizerCombiner_RISCV: List (Σ Γ,RISCVPeepholeRewrite  Γ) :=
    RISCV_identity_combines ++
    commute_int_constant_to_rhs ++
    simplify_neg ++
    mulh_to_lshr

/-- Post-legalization combine pass for LLVM specialized for i64 type -/
def PostLegalizerCombiner_LLVMIR_64 : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
  hoist_logic_op_with_same_opcode_hands_64 ++
  sub_add_reg ++
  sub_to_add ++
  select_same_val ++
  matchMulO ++
  LLVMIR_cast_combines_64 ++
  xor_of_and_with_same_reg_list ++
  LLVMIR_identity_combines_64 ++
  match_selects ++
  cast_of_cast_combines_64

/-- Post-legalization combine pass for LLVM specialized for i64 type -/
def PostLegalizerCombiner_LLVMIR_32 : List (Σ Γ, LLVMPeepholeRewriteRefine 32  Γ) :=
  LLVMIR_identity_combines_32 ++
  LLVMIR_cast_combines_32 ++
  hoist_logic_op_with_same_opcode_hands_32 ++
  cast_of_cast_combines_32 ++
  sext_trunc_fold_32 ++
  LLVMIR_identity_combines_32 ++
  cast_combines_narrow_binops

/-- We group all the rewrites that form the pre-legalization optimizations in GlobalISel-/
def GLobalISelO0PreLegalizerCombiner :
    List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  not_cmp_fold)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  double_icmp_zero_combine)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
    sub_to_add)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  mul_to_shl)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  udiv_pow2)

/-- We group all the rewrites that form the post-legalization optimizations in GlobalISel-/
def GLobalISelPostLegalizerCombiner :
    List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  redundant_binop_in_equality)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  PostLegalizerCombiner_LLVMIR_64)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  PostLegalizerCombiner_LLVMIR_32)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  canonicalize_icmp)
  ++
  List.map (fun ⟨_,y⟩ => mkRewrite (RISCVPeepholeRewriteToRiscvPeephole y))
  PostLegalizerCombiner_RISCV
  ++
  List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  select_to_iminmax
  ++
  List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  add_shift_rw
  ++
  List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  mir_pattern_combines
