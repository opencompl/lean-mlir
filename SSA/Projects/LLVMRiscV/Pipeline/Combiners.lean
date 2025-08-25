import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/- This file implements `DAGCombiner` patterns extrcted from the LLVM Risc-V backend.
  First, we implement the Lean structure that implements the rewrite patterns and then we implement
  optimizations for LLVM IR and RISC-V.
  In particular, we implement the patterns supported by LLVM's `GlobalIsel` for RISC-V.
  Because `GlobalIsel` is hybrid, some of these patterns regard generic IR,
  while some are target-dependent.
-/

@[simp_riscv] lemma toType_bv : TyDenote.toType (Ty.riscv (.bv)) = BitVec 64 := rfl
@[simp_riscv] lemma id_eq1 {α : Type} (x y : α) :  @Eq (Id α) x y = (x = y):= by simp only

structure RISCVPeepholeRewrite (Γ : Ctxt Ty) where
  lhs : Com LLVMPlusRiscV Γ .pure (Ty.riscv (.bv))
  rhs : Com LLVMPlusRiscV Γ .pure (Ty.riscv (.bv))
  correct :  (lhs.denote) = (rhs.denote) := by
    simp_lowering
    bv_decide

/-! # Post-legalization optimizations

  We implement post-legalization optimizations from LLVM's `GlobalISel` instructor selector.
  Our naming conventions are consistent with the RISC-V backend.

  LLVM's post-legalization pass is part of the combine passes described in:
  https://github.com/llvm/llvm-project/blob/d5ac1b5e2872fdafca7804d486c55334b228aaf6/llvm/lib/Target/RISCV/RISCVCombine.td

  The combine passes concerned with the RISC-V backend are described in:
  https://github.com/llvm/llvm-project/blob/d5ac1b5e2872fdafca7804d486c55334b228aaf6/llvm/include/llvm/Target/GlobalISel/Combine.td#L353

  We do not support known-bits analysis nor matching on values, and therefore do not implement the
  patterns relying on this infrastructure (e.g. `shift_immed_chain`).
-/

/-! ### sub_to_add
  (sub x, C) → (add x, -C)
-/
def sub_to_add_pat : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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

example (e : BitVec 64) : e.add 0#64 = e := by bv_decide
example : ∀ (e : BitVec 64), e.add 0#64 = e := by intros; bv_decide

/-! ### redundant_and
  (x & y) → x
  (x & y) → y
-/

def redundant_and : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
  %0 = llvm.and %x, %x : i64
  llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
  llvm.return %x : i64
  }]

/-! ### select_same_val
  (cond ? x : x) → x
-/
def select_same_val : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1), Ty.llvm (.bitvec 64) ] where
  lhs := [LV| {
  ^entry (%x: i64, %c: i1):
  %0 = llvm.select %c, %x, %x : i64
  llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64, %c: i1):
  llvm.return %x : i64
  }]

/-! ### right_identity_zero
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

def right_identity_zero_pat_ror : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

/-! ### binop_same_val
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

/-! ### binop_left_to_zero
  (0 op x) → 0
-/
def binop_left_to_zero_shl : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  %0 = sll %c, %x : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  ret %c : !riscv.reg
  }]

def binop_left_to_zero_lshr : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  %0 = srl %c, %x : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  ret %c : !riscv.reg
  }]

def binop_left_to_zero_ashr : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  %0 = sra %c, %x : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  ret %c : !riscv.reg
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

def binop_left_to_zero_srem : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  %0 = rem %c, %x : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  ret %c : !riscv.reg
  }]

def binop_left_to_zero_urem : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  %0 = remu %c, %x : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  ret %c : !riscv.reg
  }]

/-! ### binop_right_to_zero
  (x op 0) → 0
-/
def binop_left_to_zero_mul : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
  lhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  %0 = mul %c, %x : !riscv.reg
  ret %0 : !riscv.reg
  }]
  rhs := [LV| {
  ^entry (%x: !riscv.reg):
  %c = li (0) : !riscv.reg
  ret %c : !riscv.reg
  }]

/-! ### anyext_trunc_fold
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

/-! ### right_identity_one
  (x op 1) → x
-/
def right_identity_one : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

/-! ### add_sub_reg_frags
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


/-! ### simplify_neg_minmax
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
  correct := by
    simp_lowering
    simp only [BitVec.ofNat_eq_ofNat, BitVec.sub_eq, BitVec.zero_sub,
      BitVec.extractLsb'_eq_setWidth]
    sorry

/-! ### mul_to_shl
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

/-! ### mul_by_neg_one
  (mul x -1) → (sub 0 x)
-/
def mul_by_neg_one : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
