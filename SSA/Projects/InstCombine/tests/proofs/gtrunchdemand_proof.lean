
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gtrunchdemand_proof
theorem trunc_lshr_thm :
  ∀ (e : IntW 8),
    LLVM.and (trunc 6 (lshr e (const? 2))) (const? 14) ⊑ LLVM.and (lshr (trunc 6 e) (const? 2)) (const? 14) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_lshr_exact_mask_thm :
  ∀ (e : IntW 8), LLVM.and (trunc 6 (lshr e (const? 2))) (const? 15) ⊑ lshr (trunc 6 e) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_trunc_lshr_thm :
  ∀ (e : IntW 8),
    LLVM.or (trunc 6 (lshr e (const? 1))) (const? (-32)) ⊑ LLVM.or (lshr (trunc 6 e) (const? 1)) (const? (-32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_trunc_lshr_more_thm :
  ∀ (e : IntW 8),
    LLVM.or (trunc 6 (lshr e (const? 4))) (const? (-4)) ⊑ LLVM.or (lshr (trunc 6 e) (const? 4)) (const? (-4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


