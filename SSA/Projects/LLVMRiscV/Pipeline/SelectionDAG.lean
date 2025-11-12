import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
import SSA.Projects.LLVMRiscV.Pipeline.ConstantMatching

open LLVMRiscV

/-
This file implements `DAGCombiner` patterns extracted from the LLVM SelectionDAG.
-/

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
def visitADD_Sameop : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1)] where
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
def visitADD_Neg1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitADD_ZeroNegAPlusB : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitADD_APlusZeroNegB : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitADD_APlusBNegA : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitADD_BNegAPlusA : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitADD_ANegBPlusCNegA : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitADD_ANegBPlusBNegC : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitADD_APlusBNegAPlusC : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitADD_APlusBNegCPlusA : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitADD_XorNeg1Plus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitADD_XorNeg1PlusBPlus1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitADD_PlusNeg1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
 ⟨_, visitADD_Sameop⟩,
 ⟨_, visitADD_Neg1⟩,
 ⟨_, visitADD_ZeroNegAPlusB⟩,
 ⟨_, visitADD_APlusZeroNegB⟩,
 ⟨_, visitADD_APlusBNegA⟩,
 ⟨_, visitADD_BNegAPlusA⟩,
 ⟨_, visitADD_ANegBPlusCNegA⟩,
 ⟨_, visitADD_ANegBPlusBNegC⟩,
 ⟨_, visitADD_APlusBNegAPlusC⟩,
 ⟨_, visitADD_APlusBNegCPlusA⟩,
 ⟨_, visitADD_XorNeg1Plus1⟩,
 ⟨_, visitADD_XorNeg1PlusBPlus1⟩,
 ⟨_, visitADD_PlusNeg1⟩]

/-! ### visitSUB -/

/-
  fold (sub x, x) -> 0
-/
def visitSUB_XX : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitSUB_X0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitSUB_0NegXNuw : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitSUB_Neg1X : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitSUB_A0NegB : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitSUB_AANegB : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitSUB_APlusBNegA : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitSUB_APlusBNegB : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitSUB_APlusBPlusCNegB : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitSUB_APlusBNegCNegB : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitSUB_ANegBNegCNegC : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitSUB_ANegBNegC : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitSUB_ANegAAndB : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
  [⟨_, visitSUB_XX⟩,
   ⟨_, visitSUB_X0⟩,
   ⟨_, visitSUB_0NegXNuw⟩,
   ⟨_, visitSUB_Neg1X⟩,
   ⟨_, visitSUB_A0NegB⟩,
   ⟨_, visitSUB_AANegB⟩,
   ⟨_, visitSUB_APlusBNegA⟩,
   ⟨_, visitSUB_APlusBNegB⟩,
   ⟨_, visitSUB_APlusBPlusCNegB⟩,
   ⟨_, visitSUB_APlusBNegCNegB⟩,
   ⟨_, visitSUB_ANegBNegCNegC⟩,
   ⟨_, visitSUB_ANegBNegC⟩,
   ⟨_, visitSUB_ANegAAndB⟩]

/-! ### visitAND -/

/-
  fold (mul x, 0) -> 0
-/
def visitMUL_X0 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitMUL_X1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitMUL_XNeg1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitMUL_XShift : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitMUL_XNegShift : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
  [⟨_, visitMUL_X0⟩,
   ⟨_, visitMUL_X1⟩,
   ⟨_, visitMUL_XNeg1⟩,
   ⟨_, visitMUL_XShift⟩,
   ⟨_, visitMUL_XNegShift⟩]

/-! ### visitSDIV -/

/-
  fold (sdiv X, -1) -> 0-X
-/
def visitSDIV_XNeg1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
  [⟨_, visitSDIV_XNeg1⟩]


/-! ### visitAND -/

/-
  x & x --> x
-/
def visitAND_Sameop : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitAND_Neg1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
  [⟨_, visitAND_Sameop⟩,
   ⟨_, visitAND_0⟩,
   ⟨_, visitAND_Neg1⟩]

/-! ### visitOR -/

/-
  x | x --> x
-/
def visitOR_Sameop : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitOR_Neg1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitOR_And : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
  [⟨_, visitOR_Sameop⟩,
   ⟨_, visitOR_0⟩,
   ⟨_, visitOR_Neg1⟩,
   ⟨_, visitOR_And⟩]

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
def visitXOR_X : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitXOR_AddNeg1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitXOR_NotNeg : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
def visitXOR_AndXY : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
   ⟨_, visitXOR_X⟩,
   ⟨_, visitXOR_AddNeg1⟩,
   ⟨_, visitXOR_NotNeg⟩,
   ⟨_, visitXOR_AndXY⟩]

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
def visitSRA_Neg1 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
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
   ⟨_, visitSRA_Neg1⟩]

/-! ### visitSELECT -/

/-
Test the rewrite:
  select (not Cond), N1, N2 -> select Cond, N2, N1
-/
def visitSELECT_ConstantNotCond : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
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
def visitSELECT_ConstantCmpTrue : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
def visitSELECT_ConstantCmpFalse : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
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
  [⟨_, visitSELECT_ConstantNotCond⟩,
   ⟨_, visitSELECT_ConstantCmpTrue⟩,
   ⟨_, visitSELECT_ConstantCmpFalse⟩]

 /-! ### Grouped patterns -/

def SelectionDAG_combines : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :=
  visitADD ++ visitAND ++ visitSUB ++ visitMUL ++ visitSDIV ++ visitOR
  ++ visitXOR ++ visitSRA ++ visitSELECT


def SelectionDAGCombiner :
    List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  (List.map (fun ⟨_,y⟩ => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND y))
  SelectionDAG_combines)
