import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.InstCombine.ComWrappers
open LLVM
open BitVec
open ComWrappers

def lhs :
    Com InstCombine.LLVM [InstCombine.Ty.bitvec 32] .pure (InstCombine.Ty.bitvec 32) :=
  .var (const 32 (-1)) <|
  .ret ⟨0, by simp [Ctxt.snoc]⟩

def aaaaa:
    Com InstCombine.LLVM [InstCombine.Ty.bitvec 32] .pure (InstCombine.Ty.bitvec 32) :=
  .var (const 32 (-1)) <|
  .var (and 32 1 0 ) <|
  .var (add 32 2 1 ) <|
  .var (sdiv 32 1 0 ) <|
  .ret ⟨3, by simp [Ctxt.snoc]⟩

set_option pp.proofs true in
--set_option debug.skipKernelTC true in
theorem dec_mask_neg_i32_proof : lhs ⊑ aaaaa := by
  unfold lhs aaaaa
  simp only [simp_llvm_wrap]
  simp_alive_ssa -- This hangs
