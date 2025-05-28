
import SSA.Projects.LLVMRiscV.PeepholeRefine

open LLVMRiscV
/- In this file we define helper functions for our peephole rewriter such that we can reduce the overhead
to generate a peephole rewrite. We call this function from within each individual instruction module.
-/
def mkRewriteBin
  (inWidth : Nat)
  (outWidth : Nat)
  (rw : PeepholeRewrite LLVMPlusRiscV [Ty.llvm (.bitvec inWidth), Ty.llvm (.bitvec inWidth)] (Ty.llvm (.bitvec outWidth))) :
  Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty :=
  ⟨[Ty.llvm (.bitvec inWidth), Ty.llvm (.bitvec inWidth)],
   Ty.llvm (.bitvec outWidth),
   rw⟩

def mkRewriteUn
  (inWidth : Nat)
  (outWidth : Nat)
  (rw : PeepholeRewrite LLVMPlusRiscV [Ty.llvm (.bitvec inWidth)] (Ty.llvm (.bitvec outWidth))) :
  Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty :=
  ⟨[Ty.llvm (.bitvec inWidth)],
   Ty.llvm (.bitvec outWidth),
   rw⟩
