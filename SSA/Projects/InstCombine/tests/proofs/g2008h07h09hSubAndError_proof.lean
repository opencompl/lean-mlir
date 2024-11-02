
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h07h09hSubAndError_proof
theorem foo_thm (e : IntW 32) :
  LLVM.and (sub (const? 32 5) e) (const? 32 2) ⊑ LLVM.and (sub (const? 32 1) e) (const? 32 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


