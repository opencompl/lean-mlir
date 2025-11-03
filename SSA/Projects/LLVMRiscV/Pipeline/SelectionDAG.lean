import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
import SSA.Projects.LLVMRiscV.Pipeline.ConstantMatching

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

/-! ### visitADD -/

/-
  (add x, 0) -> x
-/
def visitADD_0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.add  %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      llvm.return %x : i64
  }]

/-
  add (sext i1 X), 1 -> zext (not i1 X)
-/
def visitADD_sameop : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%x: i1):
      %c = llvm.mlir.constant (1) : i64
      %0 = llvm.sext %x : i1 to i64
      %1 = llvm.add %0, %c : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i1):
      %0 = llvm.not %x : i1
      %1 = llvm.zext %0 : i1 to i64
      llvm.return %1 : i64
  }]

/-
  (and x, -1) -> x,
-/
def visitADD_minus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.and  %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      llvm.return %x : i64
  }]

/-
Test the rewrite:
  fold ((0-A)+B) -> B-A
-/
def ZeroMinusAPlusB : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.mlir.constant (0) : i64
      %1 = llvm.sub %0, %a : i64
      %2 = llvm.add %1, %b : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.sub %b, %a : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
  fold (A+(0-B)) -> A-B
-/
def APlusZeroMinusB : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.mlir.constant (0) : i64
      %1 = llvm.sub %0, %b : i64
      %2 = llvm.add %a, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.sub %a, %b : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
 fold (A+(B-A)) -> B
-/
def APlusBMinusA : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.sub %b, %a : i64
      %1 = llvm.add %a, %0 : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64):
      llvm.return %b : i64
  }]

/-
Test the rewrite:
 fold ((B-A)+A) -> B
-/
def BMinusAPlusA : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.sub %b, %a : i64
      %1 = llvm.add %0, %a : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64):
      llvm.return %b : i64
  }]

/-
Test the rewrite:
 fold ((A-B)+(C-A)) -> (C-B)
-/
def AMinusBPlusCMinusA : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %a, %b : i64
      %1 = llvm.sub %c, %a : i64
      %2 = llvm.add %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %c, %b : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
 fold ((A-B)+(B-C)) -> (A-C)
-/
def AMinusBPlusBMinusC : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %a, %b : i64
      %1 = llvm.sub %b, %c : i64
      %2 = llvm.add %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %a, %c : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
 fold (A+(B-(A+C))) -> (B-C)
-/
def APlusBMinusAPlusC : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.add %a, %c : i64
      %1 = llvm.sub %b, %0 : i64
      %2 = llvm.add %a, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %b, %c : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
 fold (A+(B-(C+A))) -> (B-C)
-/
def APlusBMinusCPlusA : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.add %c, %a : i64
      %1 = llvm.sub %b, %0 : i64
      %2 = llvm.add %a, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %b, %c : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
 fold (add (xor a, -1), 1) -> (sub 0, a)
-/
def visitADD_XorMinus1Plus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.xor %a, %c : i64
      %d = llvm.mlir.constant (1) : i64
      %1 = llvm.add %0, %d : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.sub %c, %a : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
 fold (add (add (xor a, -1), b), 1) -> (sub b, a)
-/
def visitADD_XorMinus1PlusBPlus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.xor %a, %c : i64
      %1 = llvm.add %0, %b : i64
      %d = llvm.mlir.constant (1) : i64
      %2 = llvm.add %1, %d : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.sub %b, %a : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
 (x - y) + -1  ->  add (xor y, -1), x
-/
def visitSUBPlusMinus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.sub %x, %y : i64
      %c = llvm.mlir.constant (-1) : i64
      %1 = llvm.add %0, %c : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.xor %y, %c : i64
      %1 = llvm.add %0, %x : i64
      llvm.return %1 : i64
  }]

def visitADD : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
[⟨_, visitADD_0⟩,
 ⟨_, visitADD_sameop⟩,
 ⟨_, visitADD_minus1⟩,
 ⟨_, ZeroMinusAPlusB⟩,
 ⟨_, APlusZeroMinusB⟩,
 ⟨_, APlusBMinusA⟩,
 ⟨_, BMinusAPlusA⟩,
 ⟨_, AMinusBPlusCMinusA⟩,
 ⟨_, AMinusBPlusBMinusC⟩,
 ⟨_, APlusBMinusAPlusC⟩,
 ⟨_, APlusBMinusCPlusA⟩,
 ⟨_, visitADD_XorMinus1Plus1⟩,
 ⟨_, visitADD_XorMinus1PlusBPlus1⟩,
 ⟨_, visitSUBPlusMinus1⟩]

/-! ### visitSUB -/

/-
  fold (sub x, x) -> 0
-/
def visitSUB_x_x : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.sub %x, %x : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      llvm.return %c : i64
  }]

/-
  fold (sub x, 0) -> x
-/
def visitSUB_x_0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.sub %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      llvm.return %x : i64
  }]

/-
  0 - X --> 0 if the sub is NUW.
-/
def visitSUB_0_x_nuw : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.sub %c, %x overflow<nuw>: i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      llvm.return %c : i64
  }]

/-
  Canonicalize (sub -1, x) -> ~x, i.e. (xor x, -1)
-/
def visitSUB_minus1_x : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.sub %c, %x : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.xor %x, %c : i64
      llvm.return %0 : i64
  }]

/-
  fold (A-(0-B)) -> A+B
-/
def visitSUB_A_0_minus_B : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.sub %c, %b : i64
      %1 = llvm.sub %a, %0 : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.add %a, %b : i64
      llvm.return %0 : i64
  }]

/-
  fold A-(A-B) -> B
-/
def visitSUB_A_A_minus_B : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.sub %a, %b : i64
      %1 = llvm.sub %a, %0 : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64):
      llvm.return %b : i64
  }]

/-
  fold (A+B)-A -> B
-/
def visitSUB_A_plus_B_minus_A : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.add %a, %b : i64
      %1 = llvm.sub %0, %a : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64):
      llvm.return %b : i64
  }]

/-
  fold (A+B)-B -> A
-/
def visitSUB_A_plus_B_minus_B : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.add %a, %b : i64
      %1 = llvm.sub %0, %b : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64):
      llvm.return %a : i64
  }]

/-
  fold ((A+(B+C))-B) -> A+C
-/
def visitSUB_A_plus_B_plus_C_minus_B : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.add %b, %c : i64
      %1 = llvm.add %a, %0 : i64
      %2 = llvm.sub %1, %b : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.add %a, %c : i64
      llvm.return %0 : i64
  }]

/-
  fold ((A+(B-C))-B) -> A-C
-/
def visitSUB_A_plus_B_minus_C_minus_B : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %b, %c : i64
      %1 = llvm.add %a, %0 : i64
      %2 = llvm.sub %1, %b : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %a, %c : i64
      llvm.return %0 : i64
  }]

/-
  fold ((A-(B-C))-C) -> A-B
-/
def visitSUB_A_minus_B_minus_C_minus_C : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %b, %c : i64
      %1 = llvm.sub %a, %0 : i64
      %2 = llvm.sub %1, %c : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %a, %b : i64
      llvm.return %0 : i64
  }]

/-
  fold (A-(B-C)) -> A+(C-B)
-/
def visitSUB_A_minus_B_minus_C : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %b, %c : i64
      %1 = llvm.sub %a, %0 : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64, %c: i64):
      %0 = llvm.sub %c, %b : i64
      %1 = llvm.add %a, %0 : i64
      llvm.return %1 : i64
  }]

/-
  A - (A & B)  ->  A & (~B)
-/
def visitSUB_A_minus_A_and_B : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.and %a, %b : i64
      %1 = llvm.sub %a, %0 : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%a: i64, %b: i64):
      %0 = llvm.not %b : i64
      %1 = llvm.and %a, %0 : i64
      llvm.return %1 : i64
  }]

  def visitSUB : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, visitSUB_x_x⟩,
   ⟨_, visitSUB_x_0⟩,
   ⟨_, visitSUB_0_x_nuw⟩,
   ⟨_, visitSUB_minus1_x⟩,
   ⟨_, visitSUB_A_0_minus_B⟩,
   ⟨_, visitSUB_A_A_minus_B⟩,
   ⟨_, visitSUB_A_plus_B_minus_A⟩,
   ⟨_, visitSUB_A_plus_B_minus_B⟩,
   ⟨_, visitSUB_A_plus_B_plus_C_minus_B⟩,
   ⟨_, visitSUB_A_plus_B_minus_C_minus_B⟩,
   ⟨_, visitSUB_A_minus_B_minus_C_minus_C⟩,
   ⟨_, visitSUB_A_minus_B_minus_C⟩,
   ⟨_, visitSUB_A_minus_A_and_B⟩]

/-! ### visitAND -/

/-
  fold (mul x, 0) -> 0
-/
def visitMUL_x_0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.mul %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      llvm.return %c : i64
  }]

/-
  fold (mul x, 1) -> x
-/
def visitMUL_x_1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (1) : i64
      %0 = llvm.mul %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      llvm.return %x : i64
  }]

/-
  fold (mul x, -1) -> 0-x
-/
def visitMUL_x_minus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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

/-
  fold (mul x, (1 << c)) -> x << c
-/
def visitMUL_x_shift : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %c = llvm.mlir.constant (1) : i64
      %1 = llvm.shl %c, %y : i64
      %0 = llvm.mul %x, %1 : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.shl %x, %y : i64
      llvm.return %0 : i64
  }]

/-
  fold (mul x, -(1 << c)) -> -(x << c) or (-x) << c
-/
def visitMUL_x_neg_shift : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %c = llvm.mlir.constant (1) : i64
      %1 = llvm.shl %c, %y : i64
      %2 = llvm.neg %1 : i64
      %3 = llvm.mul %x, %2 : i64
      llvm.return %3 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %y: i64):
      %1 = llvm.shl %x, %y : i64
      %2 = llvm.neg %1 : i64

      llvm.return %2 : i64
  }]

def visitMUL : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, visitMUL_x_0⟩,
   ⟨_, visitMUL_x_1⟩,
   ⟨_, visitMUL_x_minus1⟩,
   ⟨_, visitMUL_x_shift⟩,
   ⟨_, visitMUL_x_neg_shift⟩]

/-! ### visitSDIV -/

/-
  fold (sdiv X, -1) -> 0-X
-/
def visitSDIV_x_minus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.sdiv %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.sub %c, %x : i64
      llvm.return %0 : i64
  }]

def visitSDIV : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, visitSDIV_x_minus1⟩]


/-! ### visitAND -/

/-
  x & x --> x
-/
def visitAND_sameop : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.and %x, %x : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      llvm.return %x : i64
  }]

/-
  (and x, 0) -> 0,
-/
def visitAND_0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.and  %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      llvm.return %c : i64
  }]

/-
  (and x, -1) -> x,
-/
def visitAND_minus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.and  %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      llvm.return %x : i64
  }]

def visitAND : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, visitAND_sameop⟩,
  ⟨_, visitAND_0⟩,
  ⟨_, visitAND_minus1⟩]

/-! ### visitOR -/

/-
  x | x --> x
-/
def visitOR_sameop : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.or %x, %x : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      llvm.return %x : i64
  }]

/-
  fold (or x, 0) -> x
-/
def visitOR_0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.or %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      llvm.return %x : i64
  }]

/-
  fold (or x, -1) -> -1
-/
def visitOR_minus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.or %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      llvm.return %c : i64
  }]

/-
  (or (and X, M), (and X, N)) -> (and X, (or M, N))
-/
def visitOR_and : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64, %m: i64, %n: i64):
      %0 = llvm.and %x, %m : i64
      %1 = llvm.and %x, %n : i64
      %2 = llvm.or %0, %1 : i64
      llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64, %m: i64, %n: i64):
      %0 = llvm.or %m, %n : i64
      %1 = llvm.and %x, %0 : i64
      llvm.return %1 : i64
  }]

def visitOR : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, visitOR_sameop⟩,
   ⟨_, visitOR_0⟩,
   ⟨_, visitOR_minus1⟩,
   ⟨_, visitOR_and⟩]

/-! ### visitXOR -/

/-
  fold (xor x, 0) -> x
-/
def visitXOR_0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      %0 = llvm.xor %x, %c : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      llvm.return %x : i64
  }]

/-
  fold (xor x, x) -> 0
-/
def visitXOR_x : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.xor %x, %x : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (0) : i64
      llvm.return %c : i64
  }]

/-
  fold (not (add X, -1)) -> (neg X)
-/
def visitXOR_add_minus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.add %x, %c : i64
      %1 = llvm.not %0 : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.neg %x : i64
      llvm.return %0 : i64
  }]

/-
  (not (neg x)) -> (add X, -1). (osman: )
-/
def visitXOR_not_neg : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %0 = llvm.neg %x : i64
      %1 = llvm.not %0 : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.add %x, %c : i64
      llvm.return %0 : i64
  }]

/-
  fold (xor (and x, y), y) -> (and (not x), y)
-/
def visitXOR_xor_and : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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

def visitXOR : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, visitXOR_0⟩,
   ⟨_, visitXOR_x⟩,
   ⟨_, visitXOR_add_minus1⟩,
   ⟨_, visitXOR_not_neg⟩,
   ⟨_, visitXOR_xor_and⟩]

/-! ### visitSRA -/

/-
  fold (sra 0, x) -> 0
-/
def visitSRA_0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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

/-
  fold (sra -1, x) -> -1
-/
def visitSRA_minus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      %0 = llvm.ashr %c, %x : i64
      llvm.return %0 : i64
  }]
  rhs := [LV| {
    ^entry (%x: i64):
      %c = llvm.mlir.constant (-1) : i64
      llvm.return %c : i64
  }]

def visitSRA : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, visitSRA_0⟩,
   ⟨_, visitSRA_minus1⟩]

/-! ### visitSELECT -/

/-
Test the rewrite:
  select (not Cond), N1, N2 -> select Cond, N2, N1
-/
def select_constant_not_cond : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
  lhs := [LV| {
    ^entry (%c: i1, %x: i64, %y: i64):
      %0 = llvm.not %c : i1
      %1 = llvm.select %0, %x, %y : i64
      llvm.return %1 : i64
  }]
  rhs := [LV| {
    ^entry (%c: i1, %x: i64, %y: i64):
      %0 = llvm.select %c, %y, %x : i64
      llvm.return %0 : i64
  }]

/-
Test the rewrite:
  (true ? x : y) -> x
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

/-
Test the rewrite:
  (false ? x : y) -> y
-/
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

def visitSELECT : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  [⟨_, select_constant_not_cond⟩,
   ⟨_, select_constant_cmp_true⟩,
   ⟨_, select_constant_cmp_false⟩]

 /-! ### Grouped patterns -/

def SelectionDAG_combines : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  visitADD ++ visitAND ++ visitSUB ++ visitMUL ++ visitSDIV ++ visitOR ++ visitXOR ++ visitSRA ++
  visitSELECT

def SelectionDAGCombiner :
    List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  SelectionDAG_combines)
