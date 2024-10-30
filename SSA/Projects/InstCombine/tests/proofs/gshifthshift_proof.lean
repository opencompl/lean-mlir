
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthshift_proof
theorem shl_shl_thm : ∀ (e : IntW 32), shl (shl e (const? 6)) (const? 28) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_lshr_thm : ∀ (e : IntW 232), lshr (lshr e (const? 231)) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_shl_constants_div_thm :
  ∀ (e e_1 : IntW 32), LLVM.udiv e_1 (shl (shl (const? 1) e) (const? 2)) ⊑ lshr e_1 (add e (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_demand1_thm :
  ∀ (e : IntW 8),
    LLVM.or (lshr (shl (const? 40) e) (const? 3)) (const? (-32)) ⊑ LLVM.or (shl (const? 5) e) (const? (-32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_demand6_thm :
  ∀ (e : IntW 16),
    LLVM.and (lshr (shl (const? (-32624)) e) (const? 4)) (const? 4094) ⊑
      LLVM.and (shl (const? 2057) e) (const? 4094) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_shl_demand1_thm :
  ∀ (e : IntW 8),
    LLVM.or (shl (lshr (const? 28) e) (const? 3)) (const? 7) ⊑ LLVM.or (lshr (const? (-32)) e) (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


