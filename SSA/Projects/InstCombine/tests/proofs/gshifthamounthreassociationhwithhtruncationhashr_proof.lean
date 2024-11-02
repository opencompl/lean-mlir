
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthamounthreassociationhwithhtruncationhashr_proof
theorem t0_thm (e : IntW 16) (e_1 : IntW 32) :
  ashr (trunc 16 (ashr e_1 (zext 32 (sub (const? 16 32) e)))) (add e (const? 16 (-1))) ⊑
    trunc 16 (ashr e_1 (const? 32 31)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


