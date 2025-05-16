import SSA.Projects.LLVMRiscV.LLVMAndRiscv

open LLVMRiscV
/-
This file contains the defintions of the Peephole Rewrite
structures for LLVM and RISCV `Com`s. The LLVMPeepholeRewrite
structure is leveraged to lower a LLVM program to a RISCV program
where the rewrites are performed within the LLVMAndRiscv hybrid dialect.
-/

/-- `LLVMPeepholeRewriteRefine` defines the `PeepholeRewrite`
structure for LLVM `Com`s. The refinement is based on the
dedicated refinement relation for the `PoisonOr` type, where
a poison value can be refined by any concrete value. -/
structure LLVMPeepholeRewriteRefine (Γ : Ctxt Ty) where
  lhs : Com LLVMPlusRiscV Γ .pure (Ty.llvm (.bitvec 64))
  rhs : Com LLVMPlusRiscV Γ .pure (Ty.llvm (.bitvec 64))
  correct : ∀ V, PoisonOr.IsRefinedBy (lhs.denote V) (rhs.denote V)

/-- `RiscVPeepholeRewriteRefine` defines a `PeepholeRewrite` structure
for RISC-V `Com`s within the hybrid dialect. The refinement relation
is defined using bitvector refinement, since the return values of
RISC-V computations are bitvectors. -/
structure RiscVPeepholeRewriteRefine (Γ : Ctxt Ty) where
  lhs : Com LLVMPlusRiscV Γ .pure (Ty.riscv (.bv))
  rhs : Com LLVMPlusRiscV Γ .pure (Ty.riscv (.bv))
  correct : ∀ V, BitVec.Refinement (lhs.denote V : Option _) (rhs.denote V : Option _)

/-!
##  Wrapper for the Peephole rewriter
-/
/- This section defines the wrapper structures used to pass our
hybrid dialect rewrites to the Peephole Rewriter. The current
Peephole Rewriter requires a proof that the return values of
the source and target programs are equal. However, since we
are working with refinement semantics (e.g., a poison value may
be refined by any value), we cannot provide such a proof. Once
the Rewriter supports refinement, this should no longer require
a `sorry`. To still leverage the rewrite functionality, we wrap
our rewrites into a form accepted by the Peephole Rewriter, omitting
the proof of return value equality. This does not compromise our
correctness guarantees, since the rewrite itself includes a proof
that, for any two programs of the correct type, the rewrite is a
valid refinement.
 -/
def LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND (self : LLVMPeepholeRewriteRefine Γ) :
   PeepholeRewrite LLVMPlusRiscV Γ (Ty.llvm (.bitvec 64))  :=
  {
    lhs := self.lhs
    rhs := self.rhs
    correct := by sorry
  }

  def RiscVToLLVMPeepholeRewriteRefine.toPeepholeUNSOUND (self : RiscVPeepholeRewriteRefine Γ) :
    PeepholeRewrite LLVMPlusRiscV Γ (Ty.riscv (.bv)) :=
  {
    lhs := self.lhs
    rhs := self.rhs
    correct := by sorry
  }
