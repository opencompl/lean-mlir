import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/- This file implements `DAGCombiner` patterns extracted from the LLVM Risc-V backend.
  First, we implement the Lean structure that implements the rewrite patterns and then we implement
  optimizations for LLVM IR and RISC-V.
  In particular, we implement the patterns supported by LLVM's `GlobalIsel` for RISC-V.
  Because `GlobalIsel` is hybrid, some of these patterns regard generic IR,
  while some are target-dependent.
-/

@[simp_riscv] lemma toType_bv : TyDenote.toType (Ty.riscv (.bv)) = BitVec 64 := rfl
@[simp_riscv] lemma id_eq1 {α : Type} (x y : α) :  @Eq (Id α) x y = (x = y):= by simp only

structure RISCVPeepholeRewrite (Γ : List Ty) where
  lhs : Com LLVMPlusRiscV Γ .pure [Ty.riscv .bv]
  rhs : Com LLVMPlusRiscV Γ .pure [Ty.riscv .bv]
  correct : lhs.denote = rhs.denote := by simp_lowering <;> bv_decide

def RISCVPeepholeRewriteToRiscvPeephole (self : RISCVPeepholeRewrite Γ) :
    PeepholeRewrite LLVMPlusRiscV Γ [Ty.riscv .bv] where
  lhs := self.lhs
  rhs := self.rhs
  correct := self.correct

/-!
  # Post-legalization optimizations

  We implement post-legalization optimizations from LLVM's `GlobalISel` instructor selector.
  Our naming conventions are consistent with the RISC-V backend.

  We do not support known-bits analysis nor matching on values, and therefore do not implement the
  patterns relying on this infrastructure (e.g., `shift_immed_chain`).
-/

/-- ### sub_to_add
  (sub x, C) → (add x, -C)
-/
def sub_to_add_base : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant 1 : i64
    %1 = llvm.sub %x, %c : i64
    llvm.return %1 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant -1 : i64
    %1 = llvm.add %x, %c : i64
    llvm.return %1 : i64
  }]

def sub_to_add_intMax : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
  %c = llvm.mlir.constant 36893488147419103000 : i64
  %1 = llvm.sub %x, %c : i64
  llvm.return %1 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
  %c = llvm.mlir.constant -36893488147419103000: i64
  %1 = llvm.add %x, %c : i64
  llvm.return %1 : i64
  }]

def sub_to_add_intMin : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
  %c = llvm.mlir.constant 1 : i64
  %1 = llvm.sub %x, %c : i64
  llvm.return %1 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
  %c = llvm.mlir.constant -1 : i64
  %1 = llvm.add %x, %c : i64
  llvm.return %1 : i64
  }]

def sub_to_add : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
  [⟨_, sub_to_add_base⟩,
  ⟨_, sub_to_add_intMin⟩,
  ⟨_, sub_to_add_intMax⟩]

/-- ### redundant_and
  (x & y) → x
-/
def redundant_and_single : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %0 = llvm.and %x, %x : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    llvm.return %x : i64
  }]

def redundant_and_double : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
  %0 = llvm.mlir.constant 0 : i64
    %y = llvm.add %x, %0 : i64
    %1 = llvm.and %x, %y : i64
    llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
    llvm.return %x : i64
  }]

def redundant_and : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
  [⟨_, redundant_and_single⟩,
  ⟨_, redundant_and_double⟩]

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

/-- ### right_identity_zero
  (x op 0) → x
-/
def right_identity_zero_sub : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
    %c = li (0) : !riscv.reg
    %0 = sub %x, %c : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  ret %x : !riscv.reg
  }]

def right_identity_zero_add : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
    %c = li (0) : !riscv.reg
    %0 = add %x, %c : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  ret %x : !riscv.reg
  }]

def right_identity_zero_xor : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
    %c = li (0) : !riscv.reg
    %0 = xor %x, %c : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  ret %x : !riscv.reg
  }]

def right_identity_zero_shl : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
    %c = li (0) : !riscv.reg
    %0 = sll %x, %c : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  ret %x : !riscv.reg
  }]

def right_identity_zero_ashr : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
    %c = li (0) : !riscv.reg
    %0 = sra %x, %c : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  ret %x : !riscv.reg
  }]

def right_identity_zero_lshr : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
    %c = li (0) : !riscv.reg
    %0 = srl %x, %c : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  ret %x : !riscv.reg
  }]

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
  [⟨_, right_identity_zero_sub⟩,
  ⟨_, right_identity_zero_add⟩,
  ⟨_, right_identity_zero_xor⟩,
  ⟨_, right_identity_zero_shl⟩,
  ⟨_, right_identity_zero_ashr⟩,
  ⟨_, right_identity_zero_lshr⟩,
  ⟨_, right_identity_zero_rol⟩,
  ⟨_, right_identity_zero_ror ⟩]

/-- ### binop_same_val
  (x op x) → x
-/
def binop_same_val_and : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
    %0 = and %x, %x : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  ret %x : !riscv.reg
  }]

def binop_same_val_or : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
    %0 = or %x, %x : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
    ret %x : !riscv.reg
  }]

def binop_same_val : List (Σ Γ, RISCVPeepholeRewrite  Γ) :=
    [⟨_, binop_same_val_and⟩,
    ⟨_, binop_same_val_or⟩]

/-- ### binop_left_to_zero
  (0 op x) → 0
-/
def binop_left_to_zero_shl : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    %0 = llvm.shl %c, %x : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    llvm.return %c : i64
  }]

def binop_left_to_zero_lshr : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    %0 = llvm.lshr %c, %x : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    llvm.return %c : i64
  }]

def binop_left_to_zero_ashr : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    %0 = llvm.ashr %c, %x : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    llvm.return %c : i64
  }]

def binop_left_to_zero_sdiv : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    %0 = llvm.sdiv %c, %x : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    llvm.return %c : i64
  }]

def binop_left_to_zero_udiv : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    %0 = llvm.udiv %c, %x : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    llvm.return %c : i64
  }]

def binop_left_to_zero_srem : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    %0 = llvm.srem %c, %x : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    llvm.return %c : i64
  }]

def binop_left_to_zero_urem : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    %0 = llvm.urem %c, %x : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    llvm.return %c : i64
  }]

def binop_left_to_zero_mul : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    %0 = llvm.mul%c, %x : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    llvm.return %c : i64
  }]

def binop_left_to_zero: List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, binop_left_to_zero_shl⟩,
  ⟨_, binop_left_to_zero_lshr⟩,
  ⟨_, binop_left_to_zero_ashr⟩,
  ⟨_, binop_left_to_zero_sdiv⟩,
  ⟨_, binop_left_to_zero_udiv⟩,
  ⟨_, binop_left_to_zero_srem⟩,
  ⟨_, binop_left_to_zero_urem⟩,
  ⟨_, binop_left_to_zero_mul⟩]

/-- ### binop_right_to_zero
  (x op 0) → 0
-/
def binop_right_to_zero_mul : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    %0 = llvm.mul %x, %c: i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    llvm.return %c : i64
  }]

def binop_right_to_zero: List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, binop_right_to_zero_mul⟩]

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

/-- ### right_identity_one
  (x op 1) → x
-/
def right_identity_one_mul : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
    %c = li (1) : !riscv.reg
    %0 = mul %c, %x : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  ret %x : !riscv.reg
  }]

def right_identity_one : List (Σ Γ, RISCVPeepholeRewrite Γ) :=
  [⟨_, right_identity_one_mul⟩]

/-- ### add_sub_reg_frags
  (add x, (sub y, x)) → y
  (add (sub y, x), x) → y
-/
def add_sub_reg_frags_left : RISCVPeepholeRewrite [Ty.riscv (.bv), Ty.riscv (.bv) ] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg, %y: !riscv.reg ):
    %0 = sub %y, %x : !riscv.reg
    %1 = add %x, %0 : !riscv.reg
  ret %1 : !riscv.reg
  }]
  rhs := [LV| {
   ^entry (%x: !riscv.reg, %y: !riscv.reg ):
  ret %y : !riscv.reg
  }]

def add_sub_reg_frags_right : RISCVPeepholeRewrite [Ty.riscv (.bv), Ty.riscv (.bv) ] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg, %y: !riscv.reg ):
    %0 = sub %y, %x : !riscv.reg
    %1 = add %0, %x : !riscv.reg
  ret %1 : !riscv.reg
  }]
  rhs := [LV| {
   ^entry (%x: !riscv.reg, %y: !riscv.reg ):
  ret %y : !riscv.reg
  }]

def add_sub_reg_frags : List (Σ Γ, RISCVPeepholeRewrite Γ) :=
  [⟨_, add_sub_reg_frags_left⟩,
  ⟨_, add_sub_reg_frags_right⟩]

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
  correct := by sorry

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
  correct := by sorry

def simplify_neg : List (Σ Γ, RISCVPeepholeRewrite Γ) :=
  [⟨_, simplify_neg_minmax⟩,
  ⟨_, simplify_neg_maxmin⟩]


/-- ### mul_to_shl
  (x * 2) → x >>> 1
-/
def mul_to_shl_2 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (2) : i64
    %0 = llvm.mul %x, %c : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (1) : i64
    %0 = llvm.shl %x, %c : i64
    llvm.return %0 : i64
  }]

def mul_to_shl_4 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (4) : i64
    %0 = llvm.mul %x, %c : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (2) : i64
    %0 = llvm.shl %x, %c : i64
    llvm.return %0 : i64
  }]

def mul_to_shl_8 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (8) : i64
    %0 = llvm.mul %x, %c : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (3) : i64
    %0 = llvm.shl %x, %c : i64
    llvm.return %0 : i64
  }]

def mul_to_shl_16 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (16) : i64
    %0 = llvm.mul %x, %c : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (4) : i64
    %0 = llvm.shl %x, %c : i64
    llvm.return %0 : i64
  }]

def mul_to_shl_32 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (32) : i64
    %0 = llvm.mul %x, %c : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (5) : i64
    %0 = llvm.shl %x, %c : i64
    llvm.return %0 : i64
  }]

def mul_to_shl_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (64) : i64
    %0 = llvm.mul %x, %c : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (6) : i64
    %0 = llvm.shl %x, %c : i64
    llvm.return %0 : i64
  }]

def mul_to_shl_256 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (256) : i64
    %0 = llvm.mul %x, %c : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (8) : i64
    %0 = llvm.shl %x, %c : i64
    llvm.return %0 : i64
  }]

def mul_to_shl_512 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (512) : i64
    %0 = llvm.mul %x, %c : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (9) : i64
    %0 = llvm.shl %x, %c : i64
    llvm.return %0 : i64
  }]

def mul_to_shl_1024 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (1024) : i64
    %0 = llvm.mul %x, %c : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (10) : i64
    %0 = llvm.shl %x, %c : i64
    llvm.return %0 : i64
  }]

def mul_to_shl : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, mul_to_shl_2⟩,
  ⟨_,mul_to_shl_4⟩,
  ⟨_,mul_to_shl_8⟩,
  ⟨_,mul_to_shl_16⟩,
  ⟨_,mul_to_shl_32⟩,
  ⟨_,mul_to_shl_64⟩,
  ⟨_,mul_to_shl_256⟩,
  ⟨_,mul_to_shl_512⟩,
  ⟨_,mul_to_shl_1024⟩]


/-- ### mul_by_neg_one
  (mul x -1) → (sub 0 x)
-/
def mul_by_neg_one_const : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (-1) : i64
    %0 = llvm.mul %x, %c : i64
    llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
    %c = llvm.mlir.constant (0) : i64
    %0 = llvm.sub %c, %x : i64
    llvm.return %0 : i64
  }]

def mul_by_neg_one : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, mul_by_neg_one_const⟩]


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

 /-! ### Grouped patterns -/

/-- We assemble the `identity_combines` patterns for RISCV as in GlobalISel -/
def RISCV_identity_combines: List (Σ Γ, RISCVPeepholeRewrite Γ) :=
  right_identity_zero ++ binop_same_val ++ right_identity_one ++ add_sub_reg_frags

/-- We assemble the `identity_combines` patterns for LLVM as in GlobalISel -/
def LLVMIR_identity_combines_64 : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  select_same_val ++ binop_left_to_zero ++ binop_right_to_zero

def LLVMIR_identity_combines_32 : List (Σ Γ, LLVMPeepholeRewriteRefine 32 Γ) := anyext_trunc_fold

/-- Post-legalization combine pass for RISCV -/
def PostLegalizerCombiner_RISCV: List (Σ Γ,RISCVPeepholeRewrite  Γ) :=
    RISCV_identity_combines ++
    commute_int_constant_to_rhs ++
    simplify_neg

/-- Post-legalization combine pass for LLVM specialized for i64 type -/
def PostLegalizerCombiner_LLVMIR_64 : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
  sub_to_add ++
  redundant_and ++
  select_same_val ++
  LLVMIR_identity_combines_64

/-- Post-legalization combine pass for LLVM specialized for i64 type -/
def PostLegalizerCombiner_LLVMIR_32 : List (Σ Γ, LLVMPeepholeRewriteRefine 32  Γ) :=
  LLVMIR_identity_combines_32

/-- We group all the rewrites that form the pre-legalization optimizations in GlobalISel-/
def GLobalISelO0PreLegalizerCombiner :
    List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  not_cmp_fold)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
   mul_by_neg_one)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
    sub_to_add)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  mul_to_shl)

/-- We group all the rewrites that form the post-legalization optimizations in GlobalISel-/
def GLobalISelPostLegalizerCombiner :
    List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  PostLegalizerCombiner_LLVMIR_64)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  PostLegalizerCombiner_LLVMIR_32)
  ++
  List.map (fun ⟨_,y⟩ => mkRewrite (RISCVPeepholeRewriteToRiscvPeephole y))
  PostLegalizerCombiner_RISCV
