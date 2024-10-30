
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmulhpow2_proof
theorem mul_selectp2_x_thm :
  ∀ (e : IntW 8) (e_1 : IntW 1),
    mul (select e_1 (const? 2) (const? 4)) e ⊑ shl e (select e_1 (const? 1) (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_selectp2_x_propegate_nuw_thm :
  ∀ (e : IntW 8) (e_1 : IntW 1),
    mul (select e_1 (const? 2) (const? 4)) e ⊑ shl e (select e_1 (const? 1) (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_selectp2_x_non_const_thm :
  ∀ (e e_1 : IntW 8) (e_2 : IntW 1),
    mul (select e_2 (const? 2) (shl (const? 1) e_1)) e ⊑ shl e (select e_2 (const? 1) e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_x_selectp2_thm :
  ∀ (e : IntW 1) (e_1 : IntW 8),
    mul (mul e_1 e_1) (select e (const? 8) (const? 1)) ⊑ shl (mul e_1 e_1) (select e (const? 3) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_log_may_cause_poison_pr62175_fail_thm : ∀ (e e_1 : IntW 8), mul e_1 (shl (const? 4) e) ⊑ mul (shl (const? 4) e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_log_may_cause_poison_pr62175_with_nuw_thm : ∀ (e e_1 : IntW 8), mul e_1 (shl (const? 4) e) ⊑ shl e_1 (add e (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_log_may_cause_poison_pr62175_with_nsw_thm : ∀ (e e_1 : IntW 8), mul e_1 (shl (const? 4) e) ⊑ shl e_1 (add e (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


