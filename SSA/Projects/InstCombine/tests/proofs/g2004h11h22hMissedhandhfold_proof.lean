
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2004h11h22hMissedhandhfold_proof
theorem test21_thm (e : IntW 8) : LLVM.and (ashr e (const? 8 7)) (const? 8 1) ⊑ lshr e (const? 8 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


