import SSA.Core

import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.tactics.SimpLowering

open LLVMRiscV

/-!
  This file contains the definitions of the Peephole Rewrite structures for LLVM and RISCV `Com`s.
  Additionally this file defines the wrapper structures used to pass our hybrid dialect rewrites to the Peephole Rewriter.

  The current Peephole Rewriter requires a proof that the return values of the source and target
  programs are equal. Because we are working with refinement semantics (e.g., poison), we cannot provide such a proof and therefore leave the proof as `sorry`. This will no longer be required once the
  rewriter supports refinement.
-/

instance : Refinement (BitVec w) := .ofEq
@[simp] theorem bv_isRefinedBy_iff (x y : BitVec w) : x ⊑ y ↔ x = y := by rfl

/-- `LLVMPeepholeRewriteRefine` defines the `PeepholeRewrite` structure for LLVM `Com`s, containing
  a default proof strategy that targets the correctness claim. If this strategy fails, Lean will
  throw an error message.
  The refinement is based on the semantics of `PoisonOr`. -/
structure LLVMPeepholeRewriteRefine (w : Nat) (Γ : List Ty) where
  lhs : Com LLVMPlusRiscV Γ .pure (Ty.llvm (.bitvec w))
  rhs : Com LLVMPlusRiscV Γ .pure (Ty.llvm (.bitvec w))
  correct : ∀ V,
    PoisonOr.IsRefinedBy (lhs.denote V) (rhs.denote V) := by
      simp_lowering <;> bv_decide

/-- `LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND` is a wrapper to pass the rewrites to the
  Peephole Rewriter, with a `sorry` replacing the correctness proof which cannot be provided,
  given that we are working with refinement semantics. -/
def LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND
  (self : LLVMPeepholeRewriteRefine w Γ) :
   PeepholeRewrite LLVMPlusRiscV Γ (Ty.llvm (.bitvec w))  :=
  {
    lhs := self.lhs
    rhs := self.rhs
    correct := by sorry
  }
