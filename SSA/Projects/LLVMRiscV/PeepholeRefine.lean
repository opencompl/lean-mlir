import SSA.Projects.LLVMRiscV.LLVMAndRiscv

open LLVMRiscV
/-!
This file contains the definitions of the Peephole Rewrite
structures for LLVM and RISCV `Com`s. The LLVMPeepholeRewrite
structure is leveraged to lower a LLVM program to a RISCV program
where the rewrites are performed within the LLVMAndRiscv hybrid dialect.
Additionally this file defines the wrapper structures used to pass our
hybrid dialect rewrites to the Peephole Rewriter. The current
Peephole Rewriter requires a proof that the return values of
the source and target programs are equal. However, since we
are working with refinement semantics (e.g., a poison value may
be refined by any value), we cannot provide such a proof. Once
the Rewriter supports refinement, this file should no longer require
a `sorry`. To still leverage the rewrite functionality, we wrap
our rewrites into a form accepted by the Peephole Rewriter.
 -/


/-- `LLVMPeepholeRewriteRefine` defines the `PeepholeRewrite`
structure for LLVM `Com`s. The refinement is based on the
dedicated refinement relation for the `PoisonOr` type, where
a poison value can be refined by any concrete value. -/
structure LLVMPeepholeRewriteRefine (Γ : Ctxt Ty) where
  lhs : Com LLVMPlusRiscV Γ .pure (Ty.llvm (.bitvec 64))
  rhs : Com LLVMPlusRiscV Γ .pure (Ty.llvm (.bitvec 64))
  correct : ∀ V,
    PoisonOr.IsRefinedBy (lhs.denote V) (rhs.denote V)

/-!
##  Wrapper for the Peephole Rewriter
-/
 /--
 `LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND` defines
a wrapper to pass our rewrites to the Peephole Rewriter.
We cannot provide the required equality proof therefore
we sorry the proof. This does not compromise our
correctness guarantees, since the rewrite itself provide that.
We still hint the unsoudness of the Peephole
Rewrite because in fact the proof is not provided and can't be
provided until the Peephole Rewriter accepts refinements.
 -/
def LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND
  (self : LLVMPeepholeRewriteRefine Γ) :
   PeepholeRewrite LLVMPlusRiscV Γ (Ty.llvm (.bitvec 64))  :=
  {
    lhs := self.lhs
    rhs := self.rhs
    correct := by sorry
  }
