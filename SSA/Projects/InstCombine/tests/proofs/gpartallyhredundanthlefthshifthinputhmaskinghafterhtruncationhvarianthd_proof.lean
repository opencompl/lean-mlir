
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gpartallyhredundanthlefthshifthinputhmaskinghafterhtruncationhvarianthd_proof
theorem PR51351_thm :
  ∀ (e : IntW 64) (e_1 : IntW 32),
    shl (trunc 32 (LLVM.and (ashr (shl (const? (-1)) (zext 64 e_1)) (zext 64 e_1)) e)) (add e_1 (const? (-33))) ⊑
      shl (trunc 32 e) (add e_1 (const? (-33))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry

