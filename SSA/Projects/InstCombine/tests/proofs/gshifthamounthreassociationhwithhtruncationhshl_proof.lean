
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthamounthreassociationhwithhtruncationhshl_proof
theorem t0_thm (e : IntW 16) (e_1 : IntW 32) :
  shl (trunc 16 (shl e_1 (zext 32 (sub (const? 16 32) e)))) (add e (const? 16 (-24))) ⊑
    shl (trunc 16 e_1) (const? 16 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


