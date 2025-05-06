
import RiscvDialect.LLVMRiscv.LLVMAndRiscV

open LLVMRiscV
/-!
This file contains the defintion of the Peephole Rewrite structure for LLVM and RISCV.
The LLVMPeepholeRewrite structure is leveraged to lower LLVM program to a RISCV program where we insert unrealized conversion cast
from LLVM to RISCV and eliminate them in a subsequent pass to completely lower the program.
-/
structure LLVMPeepholeRewriteRefine (Γ : Ctxt Ty) where
  lhs : Com LLVMPlusRiscV Γ .pure (Ty.llvm (.bitvec 64))
  rhs : Com LLVMPlusRiscV Γ .pure (Ty.llvm (.bitvec 64))
  correct : ∀ V, BitVec.Refinement (lhs.denote V : Option _) (rhs.denote V : Option _)

structure RiscVPeepholeRewriteRefine (Γ : Ctxt Ty) where
  lhs : Com LLVMPlusRiscV Γ .pure (Ty.riscv (.bv))
  rhs : Com LLVMPlusRiscV Γ .pure (Ty.riscv (.bv))
  correct : ∀ V, BitVec.Refinement (lhs.denote V : Option _) (rhs.denote V : Option _)

/--
##  Wrapper for peephole rewriter
-/
def LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND (self : LLVMPeepholeRewriteRefine Γ) : PeepholeRewrite LLVMPlusRiscV Γ (Ty.llvm (.bitvec 64))  :=
  {
    lhs := self.lhs
    rhs := self.rhs
    correct := by sorry
  }

  def RiscVToLLVMPeepholeRewriteRefine.toPeepholeUNSOUND (self : RiscVPeepholeRewriteRefine Γ) : PeepholeRewrite LLVMPlusRiscV Γ (Ty.riscv (.bv)) :=
  {
    lhs := self.lhs
    rhs := self.rhs
    correct := by sorry
  }
