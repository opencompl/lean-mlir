
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthamounthreassociationhwithhtruncationhashr_proof
theorem t0_thm (e✝ : IntW 16) (e✝¹ : IntW 32) :
  ashr (trunc 16 (ashr e✝¹ (zext 32 (sub (const? 32) e✝)))) (add e✝ (const? (-1))) ⊑
    trunc 16 (ashr e✝¹ (const? 31)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


