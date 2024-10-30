
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthadd_proof
theorem ashr_C1_add_A_C2_i32_thm : ∀ (e : IntW 32), ashr (const? 6) (add (LLVM.and e (const? 65535)) (const? 5)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_C1_add_A_C2_i32_thm :
  ∀ (e : IntW 32),
    shl (const? 6) (add (LLVM.and e (const? 65535)) (const? 5)) ⊑ shl (const? 192) (LLVM.and e (const? 65535)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_nuw_thm : ∀ (e : IntW 32), shl (const? 6) (add e (const? 5)) ⊑ shl (const? 192) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nuw_add_nuw_thm : ∀ (e : IntW 32), shl (const? 1) (add e (const? 1)) ⊑ shl (const? 2) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_add_nuw_thm : ∀ (e : IntW 32), shl (const? (-1)) (add e (const? 1)) ⊑ shl (const? (-2)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_exact_add_nuw_thm : ∀ (e : IntW 32), lshr (const? 4) (add e (const? 1)) ⊑ lshr (const? 2) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_exact_add_nuw_thm : ∀ (e : IntW 32), ashr (const? (-4)) (add e (const? 1)) ⊑ ashr (const? (-2)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_exact_add_negative_shift_positive_thm : ∀ (e : IntW 32), lshr (const? 2) (add e (const? (-1))) ⊑ lshr (const? 4) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_exact_add_negative_shift_negative_thm : ∀ (e : IntW 32), ashr (const? (-2)) (add e (const? (-1))) ⊑ ashr (const? (-4)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_add_negative_thm : ∀ (e : IntW 32), shl (const? 2) (add e (const? (-1))) ⊑ shl (const? 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_add_negative_invalid_constant3_thm :
  ∀ (e : IntW 4), shl (const? 2) (add e (const? (-8))) ⊑ shl (const? 2) (LLVM.xor e (const? (-8))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


