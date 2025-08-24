import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/- This file implements DAGCombiner pattterns extrcted from the LLVM Risc-V backend. First we implement
the Lean structure that implements the rewrite patterns and then we implement optimizations on the
LLVM IR and RISC-V level.
Implemented the ones that GlobalISel supports and GlobalIsel is hybrid meaning some
of them are in a generic machine IR others are in a target-dependent IR -/
@[simp_riscv] lemma toType_bv : TyDenote.toType (Ty.riscv (.bv)) = BitVec 64 := rfl
@[simp_riscv] lemma id_eq1 {α : Type} (x y : α) :  @Eq (Id α) x y = (x = y):=
by simp

structure RISCVPeepholeRewrite (Γ : List Ty) where
  lhs : Com LLVMPlusRiscV Γ .pure (Ty.riscv (.bv))
  rhs : Com LLVMPlusRiscV Γ .pure (Ty.riscv (.bv))
  correct :  (lhs.denote) = (rhs.denote) := by
    simp_lowering
    bv_decide

def RISCVPeepholeRewriteToRiscvPeephole
  (self : RISCVPeepholeRewrite Γ) :
   PeepholeRewrite LLVMPlusRiscV Γ (Ty.riscv (.bv))  :=
  {
    lhs := self.lhs
    rhs := self.rhs
    correct := self.correct
  }

/-
The section below implements post-legalization optimizations from the RISC-V GlobalISel instruction selector.
We adopt the naming conventions used in the RISC-V backend for each optimization. The first file linked below defines three
combine passes, one of which specifically corresponds to the post-legalization phase whereas as the 2nd
linked file contains the combines from the RISC-V backend.:
https://github.com/llvm/llvm-project/blob/d5ac1b5e2872fdafca7804d486c55334b228aaf6/llvm/lib/Target/RISCV/RISCVCombine.td

https://github.com/llvm/llvm-project/blob/d5ac1b5e2872fdafca7804d486c55334b228aaf6/llvm/include/llvm/Target/GlobalISel/Combine.td#L353
-/

/-! # GLOBALISel Combiners taken from the post legalization pass labeled as optimizations. -/
--  Post-legalization combines which are primarily optimizations.


/-! # sub_to_add, class constant opt -/
/-
// (sub x, C) -> (add x, -C)
def sub_to_add : GICombineRule<
  (defs root:$d, build_fn_matchinfo:$matchinfo),
  (match (G_CONSTANT $c, $imm),
         (G_SUB $d, $op1, $c):$mi,
         [{ return Helper.matchCombineSubToAdd(*${mi}, ${matchinfo}); }]),
  (apply [{ Helper.applyBuildFnNoErase(*${mi}, ${matchinfo}); }])>;
-/
def llvm_sub_to_add_pat_1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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

def llvm_sub_to_add_pat_64intMax : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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

def llvm_sub_to_add_pat_64intMin : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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

 def LLVMIR_sub_to_add : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
    [⟨_, llvm_sub_to_add_pat_1⟩,
    ⟨_, llvm_sub_to_add_pat_64intMax⟩,
    ⟨_, llvm_sub_to_add_pat_64intMin⟩]

/-! # redundant add class value/bit-tracking opt -/
-- / Fold (x & y) -> x or (x & y) -> y when (x & y) is known to equal x or equal y
-- This could be known through the various tracking that LLVM performs.
-- example instance, relies on known-bits analysis.

def llvm_redundant_and_single : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
  ^entry (%x: i64):
  %0 = llvm.and %x, %x : i64
  llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64):
  llvm.return %x : i64
  }]

def llvm_redundant_and_double : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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

 def LLVMIR_redundant_add : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
    [⟨_, llvm_redundant_and_single⟩,
    ⟨_, llvm_redundant_and_double⟩]

/-! # select_same_val in identity_combines-/
-- Fold (cond ? x : x) -> x
-- def select_same_val: GICombineRule<
--   (defs root:$root),
--   (match (wip_match_opcode G_SELECT):$root,
--     [{ return Helper.matchSelectSameVal(*${root}); }]),
--   (apply [{ Helper.replaceSingleDefInstWithOperand(*${root}, 2); }])
-- >; -/

def select_same_val_pat : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1), Ty.llvm (.bitvec 64) ] where
  lhs := [LV| {
  ^entry (%x: i64, %c: i1):
  %0 = llvm.select %c, %x, %x : i64
  llvm.return %0 : i64
  }]
  rhs := [LV| {
  ^entry (%x: i64, %c: i1):
  llvm.return %x : i64
  }]

 def LLVMIR_select_same_val : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
    [⟨_, select_same_val_pat⟩]

/-! # right_identity_zero in identity_combines-/
-- // Fold x op 0 -> x
-- def right_identity_zero_frags : GICombinePatFrag<
--   (outs root:$dst), (ins $x),
--   !foreach(op,
--            [G_SUB, G_ADD, G_OR, G_XOR, G_SHL, G_ASHR,
--             G_LSHR, G_PTR_ADD, G_ROTL, G_ROTR],
--            (pattern (op $dst, $x, 0)))>;
-- def right_identity_zero: GICombineRule<
--   (defs root:$dst),
--   (match (right_identity_zero_frags $dst, $lhs)),
--   (apply (GIReplaceReg $dst, $lhs))
-- >;
def right_identity_zero_pat_sub : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

def right_identity_zero_pat_add : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

def right_identity_zero_pat_xor : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

def right_identity_zero_pat_shl : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

def right_identity_zero_pat_ashr : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

def right_identity_zero_pat_lshr : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

def right_identity_zero_pat_rotl : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

def right_identity_zero_pat_rotr : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

 def RISCV_right_identity_zero : List (Σ Γ, RISCVPeepholeRewrite  Γ) :=
    [⟨_, right_identity_zero_pat_sub⟩,
    ⟨_, right_identity_zero_pat_add⟩,
    ⟨_, right_identity_zero_pat_xor⟩,
    ⟨_, right_identity_zero_pat_shl⟩,
    ⟨_, right_identity_zero_pat_ashr⟩,
    ⟨_, right_identity_zero_pat_lshr⟩,
    ⟨_, right_identity_zero_pat_rotl⟩,
    ⟨_, right_identity_zero_pat_rotr ⟩]

/-! # binop_same_val in identity_combines -/
-- // Fold (x op x) - > x
-- def binop_same_val_frags : GICombinePatFrag<
--   (outs root:$dst), (ins $x),
--   [
--     (pattern (G_AND $dst, $x, $x)),
--     (pattern (G_OR $dst, $x, $x)),
--   ]
-- >;
-- def binop_same_val: GICombineRule<
--   (defs root:$dst),
--   (match (binop_same_val_frags $dst, $src)),
--   (apply (GIReplaceReg $dst, $src))
-- >;

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

 def RISCV_binop_same_val : List (Σ Γ, RISCVPeepholeRewrite  Γ) :=
    [⟨_, binop_same_val_and⟩,
    ⟨_, binop_same_val_or⟩]

/-! # binop_left_to_zero in identity_combines -/
-- // Fold (0 op x) - > 0
-- def binop_left_to_zero: GICombineRule<
--   (defs root:$root),
--   (match (wip_match_opcode G_SHL, G_LSHR, G_ASHR, G_SDIV, G_UDIV, G_SREM,
--                            G_UREM):$root,
--     [{ return Helper.matchOperandIsZero(*${root}, 1); }]),
--   (apply [{ Helper.replaceSingleDefInstWithOperand(*${root}, 1); }])
-- >;
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

def binop_left_to_zero_lshr :LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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

 def LLVMIR_binop_left_to_zero: List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
    [⟨_, binop_left_to_zero_shl⟩,
    ⟨_, binop_left_to_zero_lshr⟩,
    ⟨_, binop_left_to_zero_ashr⟩,
    ⟨_, binop_left_to_zero_sdiv⟩,
    ⟨_, binop_left_to_zero_udiv⟩,
    ⟨_, binop_left_to_zero_srem⟩,
    ⟨_, binop_left_to_zero_urem⟩,
    ⟨_, binop_left_to_zero_mul⟩]

/-! # binop_right_to_zero in identity_combines -/
-- // Fold (x op 0) - > 0
-- def binop_right_to_zero: GICombineRule<
--   (defs root:$dst),
--   (match (G_MUL $dst, $lhs, 0:$zero)),
--   (apply (GIReplaceReg $dst, $zero))
-- >;

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

 def LLVMIR_binop_right_to_zero: List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
    [⟨_, binop_right_to_zero_mul⟩]

/-! # p2i_to_i2p and i2p_to_p2i -- mention that can't implement pointer optimizations -/
-- // Fold int2ptr(ptr2int(x)) -> x
-- def p2i_to_i2p: GICombineRule<
--   (defs root:$root, register_matchinfo:$info),
--   (match (wip_match_opcode G_INTTOPTR):$root,
--     [{ return Helper.matchCombineI2PToP2I(*${root}, ${info}); }]),
--   (apply [{ Helper.applyCombineI2PToP2I(*${root}, ${info}); }])
-- >;

/-! # anyext_trunc_fold in identity_combines -/
-- / Fold (anyext (trunc x)) -> x if the source type is same as
-- // the destination type.
-- def anyext_trunc_fold: GICombineRule <
--   (defs root:$root, register_matchinfo:$matchinfo),
--   (match (wip_match_opcode G_ANYEXT):$root,
--          [{ return Helper.matchCombineAnyExtTrunc(*${root}, ${matchinfo}); }]),
--   (apply [{ Helper.replaceSingleDefInstWithReg(*${root}, ${matchinfo}); }])
-- >;
-- here in the future we can support more patterns
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

 def LLVMIR_anyext_trunc_fold: List (Σ Γ, LLVMPeepholeRewriteRefine 32 Γ) :=
    [⟨_, anyext_trunc_fold_sext_32⟩,
    ⟨_, anyext_trunc_fold_zext_32⟩]

/-! # right_identity_one_int in identity_combines -/
-- // Fold x op 1 -> x
-- def right_identity_one_int: GICombineRule<
--   (defs root:$dst),
--   (match (G_MUL $dst, $x, 1)),
--   (apply (GIReplaceReg $dst, $x))
-->;

def right_identity_one_int : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

 def RISCV_right_identity_one: List (Σ Γ, RISCVPeepholeRewrite Γ) :=
    [⟨_,right_identity_one_int⟩]

/-! # add_sub_reg_frags in identity_combines -/
-- // Transform (add x, (sub y, x)) -> y
-- // Transform (add (sub y, x), x) -> y
-- def add_sub_reg_frags : GICombinePatFrag<
--   (outs root:$dst), (ins $src),
--   [
--     (pattern (G_ADD $dst, $x, $tmp), (G_SUB $tmp, $src, $x)),
--     (pattern (G_ADD $dst, $tmp, $x), (G_SUB $tmp, $src, $x))
--   ]>;
-- def add_sub_reg: GICombineRule <
--   (defs root:$dst),
--   (match (add_sub_reg_frags $dst, $src)),
--   (apply (GIReplaceReg $dst, $src))>;

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

 def RISCV_add_sub_reg_frags: List (Σ Γ, RISCVPeepholeRewrite Γ) :=
    [⟨_,add_sub_reg_frags_left⟩,
    ⟨_,add_sub_reg_frags_right⟩]

/-! # assembling the identity_combines pattern group as found in GlobalISel-/
 def RISCV_identity_combines: List (Σ Γ, RISCVPeepholeRewrite Γ) :=
  RISCV_right_identity_zero ++ RISCV_binop_same_val ++ RISCV_right_identity_one
  ++ RISCV_add_sub_reg_frags

def LLVMIR_identity_combines : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  LLVMIR_select_same_val ++ LLVMIR_binop_left_to_zero ++ LLVMIR_binop_right_to_zero

def LLVMIR_identity_combines_32 : List (Σ Γ, LLVMPeepholeRewriteRefine 32 Γ) :=
  LLVMIR_anyext_trunc_fold

/-! # shift_immed_chain -/
/- this is an optimization that matches on the value of the bits therefore we currently can't implement it
(efficiently) and each time I choose a representative of that optimization.-/
-- shift_immed_chain,
-- def shift_immed_chain : GICombineRule<
--   (defs root:$d, shift_immed_matchdata:$matchinfo),
--   (match (wip_match_opcode G_SHL, G_ASHR, G_LSHR, G_SSHLSAT, G_USHLSAT):$d,
--          [{ return Helper.matchShiftImmedChain(*${d}, ${matchinfo}); }]),
--   (apply [{ Helper.applyShiftImmedChain(*${d}, ${matchinfo}); }])>;
-- void CombinerHelper::applyShiftImmedChain(MachineInstr &MI,
--                                           RegisterImmPair &MatchInfo) const {
--   unsigned Opcode = MI.getOpcode();
--   assert((Opcode == TargetOpcode::G_SHL || Opcode == TargetOpcode::G_ASHR ||
--           Opcode == TargetOpcode::G_LSHR || Opcode == TargetOpcode::G_SSHLSAT ||
--           Opcode == TargetOpcode::G_USHLSAT) &&
--          "Expected G_SHL, G_ASHR, G_LSHR, G_SSHLSAT or G_USHLSAT");

-- def shift_immed_chain_lshr: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
--   lhs := [LV| {
--   ^entry (%base: i64, %x: i64, %y: i64):
--   %0 = llvm.lshr %base, %x: i64
--   %1 = llvm.lshr %0, %y : i64
--   llvm.return %1 : i64
--   }]
--   rhs := [LV| {
--    ^entry (%base: i64, %x: i64, %y: i64):
--   %0 = llvm.add %x, %y: i64
--   %1 = llvm.lshr %base, %0 : i64
--   llvm.return %1 : i64
--   }]

  -- def shift_immed_chain_ashr : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  -- lhs := [LV| {
  -- ^entry (%base: i64, %x: i64, %y: i64):
  -- %0 = llvm.ashr %base, %x: i64
  -- %1 = llvm.ashr %0, %y : i64
  -- llvm.return %1 : i64
  -- }]
  -- rhs := [LV| {
  --  ^entry (%base: i64, %x: i64, %y: i64):
  -- %0 = llvm.add %x, %y: i64
  -- %1 = llvm.ashr %base, %0 : i64
  -- llvm.return %1 : i64
  -- }]

  -- def shift_immed_chain_lshr : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  -- lhs := [LV| {
  -- ^entry (%base: i64, %x: i64, %y: i64):
  -- %0 = llvm.ashr %base, %x: i64
  -- %1 = llvm.ashr %0, %y : i64
  -- llvm.return %1 : i64
  -- }]
  -- rhs := [LV| {
  --  ^entry (%base: i64, %x: i64, %y: i64):
  -- %0 = llvm.add %x, %y: i64
  -- %1 = llvm.ashr %base, %0 : i64
  -- llvm.return %1 : i64
  -- }]

/-! # commute_constant_to_rhs -/
/- This optimization is implemented in GlobalISel however in our case as we can't match on values
we cannot support the generic pattern and rather only the implement an example that showcases the general
us of it.-/
/- This type of optimization is a canoncializing rewrite-/
-- // Fold (C op x) -> (x op C)
-- // TODO: handle more isCommutable opcodes
-- // TODO: handle compares (currently not marked as isCommutable)
-- def commute_int_constant_to_rhs : GICombineRule<
--   (defs root:$root),
--   (match (wip_match_opcode G_ADD, G_MUL, G_AND, G_OR, G_XOR,
--                            G_SMIN, G_SMAX, G_UMIN, G_UMAX, G_UADDO, G_SADDO,
--                            G_UMULO, G_SMULO, G_UMULH, G_SMULH,
--                            G_UADDSAT, G_SADDSAT, G_SMULFIX, G_UMULFIX,
--                            G_SMULFIXSAT, G_UMULFIXSAT):$root,
--     [{ return Helper.matchCommuteConstantToRHS(*${root}); }]),
--   (apply [{ Helper.applyCommuteBinOpOperands(*${root}); }])
-- >;
  def commute_int_constant_to_rhs_ADD : RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

  def commute_int_constant_to_rhs_MUL: RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

  def commute_int_constant_to_rhs_AND: RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

  def commute_int_constant_to_rhs_OR: RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

  def commute_int_constant_to_rhs_XOR: RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

-- unsigned
  def commute_int_constant_to_rhs_MULH: RISCVPeepholeRewrite [Ty.riscv (.bv)] where
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

 def RISCV_commute_int_constant_to_rhs: List (Σ Γ, RISCVPeepholeRewrite  Γ) :=
    [⟨_, commute_int_constant_to_rhs_ADD⟩,
    ⟨_, commute_int_constant_to_rhs_MUL⟩,
    ⟨_, commute_int_constant_to_rhs_AND⟩,
    ⟨_, commute_int_constant_to_rhs_OR⟩,
    ⟨_, commute_int_constant_to_rhs_XOR⟩,
    ⟨_, commute_int_constant_to_rhs_MULH⟩]

--! # simplify_neg_minmax -/
-- // (neg (min/max x, (neg x))) --> (max/min x, (neg x))
-- bool CombinerHelper::matchSimplifyNegMinMax(MachineInstr &MI,
--                                             BuildFnTy &MatchInfo) const {
--   assert(MI.getOpcode() == TargetOpcode::G_SUB);
--   Register DestReg = MI.getOperand(0).getReg();
--   LLT DestTy = MRI.getType(DestReg);

--   Register X;
--   Register Sub0;
--   auto NegPattern = m_all_of(m_Neg(m_DeferredReg(X)), m_Reg(Sub0));
--   if (mi_match(DestReg, MRI,
--                m_Neg(m_OneUse(m_any_of(m_GSMin(m_Reg(X), NegPattern),
--                                        m_GSMax(m_Reg(X), NegPattern),
--                                        m_GUMin(m_Reg(X), NegPattern),
--                                        m_GUMax(m_Reg(X), NegPattern)))))) {
--     MachineInstr *MinMaxMI = MRI.getVRegDef(MI.getOperand(2).getReg());
--     unsigned NewOpc = getInverseGMinMaxOpcode(MinMaxMI->getOpcode());
--     if (isLegal({NewOpc, {DestTy}})) {
--       MatchInfo = [=](MachineIRBuilder &B) {
--         B.buildInstr(NewOpc, {DestReg}, {X, Sub0});
--       };
--       return true;
--     }
--   }
--   return false;
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
    simp
    bv_decide
    sorry

 def RISCV_simplify_neg_minmax: List (Σ Γ, RISCVPeepholeRewrite  Γ) :=
    [⟨_, simplify_neg_minmax ⟩]

/-! # PostLegalizerCombiner in Lean.  -/
--We modell the following pass in Lean based on the extracted rewrites implemented above.
-- def RISCVPostLegalizerCombiner
--     : GICombiner<"RISCVPostLegalizerCombinerImpl",
--                  [sub_to_add, combines_for_extload, redundant_and,
--                   identity_combines, shift_immed_chain,
--                   commute_constant_to_rhs, simplify_neg_minmax]> {
-- }
 def PostLegalizerCombiner_RISCV: List (Σ Γ,RISCVPeepholeRewrite  Γ) :=
    RISCV_identity_combines ++
    RISCV_commute_int_constant_to_rhs ++
    RISCV_simplify_neg_minmax

 def PostLegalizerCombiner_LLVMIR_64 : List (Σ Γ, LLVMPeepholeRewriteRefine 64  Γ) :=
  LLVMIR_sub_to_add ++ LLVMIR_redundant_add ++ LLVMIR_select_same_val
  ++ LLVMIR_identity_combines

 def PostLegalizerCombiner_LLVMIR_32 : List (Σ Γ, LLVMPeepholeRewriteRefine 32  Γ) :=
  LLVMIR_identity_combines_32

def GLobalISel_In_Lean_PostLegalizerCombiner_RISCV :
  List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  PostLegalizerCombiner_LLVMIR_64)
  ++
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  PostLegalizerCombiner_LLVMIR_32)
  ++
  List.map (fun ⟨_,y⟩ => mkRewrite (RISCVPeepholeRewriteToRiscvPeephole y))
  PostLegalizerCombiner_RISCV




/-
def RISCVPreLegalizerCombiner: GICombiner<
  "RISCVPreLegalizerCombinerImpl", [all_combines]> {
}

def RISCVO0PreLegalizerCombiner: GICombiner<
  "RISCVO0PreLegalizerCombinerImpl", [optnone_combines]> {
}

// Post-legalization combines which are primarily optimizations.

/ TODO: Add more combines.
def RISCVPostLegalizerCombiner
    : GICombiner<"RISCVPostLegalizerCombinerImpl",
                 [sub_to_add, combines_for_extload, redundant_and,
                  identity_combines, shift_immed_chain,
                  commute_constant_to_rhs, simplify_neg_minmax]> {
}

-/
/-! # GLOBALISel Combiners taken from the pre-legalization pass run at the O1-O3 optimization levels.
.-/
/-
def RISCVPreLegalizerCombiner: GICombiner<
  "RISCVPreLegalizerCombinerImpl", [all_combines]> {
} -/

/-! # GLOBALISel Combiners taken from the pre-legalization pass run at the O0 optimization level.
.-/
/-
-- ; // A combine group used to for prelegalizer combiners at -O0. The combines in
-- ; // this group have been selected based on experiments to balance code size and
-- ; // compile time performance.
-- ; def optnone_combines : GICombineGroup<[trivial_combines,
-- ;     ptr_add_immed_chain, combines_for_extload,
-- ;     not_cmp_fold, opt_brcond_by_inverting_cond, combine_concat_vector]>;

def trivial_combines : GICombineGroup<[copy_prop, mul_to_shl, sub_to_add,
                                       add_p2i_to_ptradd, mul_by_neg_one,
                                       idempotent_prop]>;
-/

-- NO copy_prop

-- def mul_to_shl : GICombineRule<
--   (defs root:$d, unsigned_matchinfo:$matchinfo),
--   (match (G_MUL $d, $op1, $op2):$mi,
--          [{ return Helper.matchCombineMulToShl(*${mi}, ${matchinfo}); }]),
--   (apply [{ Helper.applyCombineMulToShl(*${mi}, ${matchinfo}); }])>;
-- rewrites any multiplication by a power of 2 into a shift
def mul_to_shl : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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


-- sub to add already above

-- NO add_p2i_to_ptradd

-- mul_by_neg_one
-- / Transform (mul x, -1) -> (sub 0, x)
-- def mul_by_neg_one: GICombineRule <
--   (defs root:$dst),
--   (match (G_MUL $dst, $x, -1)),
--   (apply (G_SUB $dst, 0, $x))
-- >;
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

-- idempotent_prop
