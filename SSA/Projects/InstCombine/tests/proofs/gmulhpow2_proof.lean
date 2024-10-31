
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmulhpow2_proof
theorem mul_selectp2_x_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  mul (select e✝¹ (const? 2) (const? 4)) e✝ ⊑ shl e✝ (select e✝¹ (const? 1) (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_selectp2_x_propegate_nuw_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  mul (select e✝¹ (const? 2) (const? 4)) e✝ { «nsw» := true, «nuw» := true } ⊑
    shl e✝ (select e✝¹ (const? 1) (const? 2)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_selectp2_x_non_const_thm (e✝ e✝¹ : IntW 8) (e✝² : IntW 1) :
  mul (select e✝² (const? 2) (shl (const? 1) e✝¹)) e✝ ⊑ shl e✝ (select e✝² (const? 1) e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_x_selectp2_thm (e✝ : IntW 1) (e✝¹ : IntW 8) :
  mul (mul e✝¹ e✝¹) (select e✝ (const? 8) (const? 1)) ⊑ shl (mul e✝¹ e✝¹) (select e✝ (const? 3) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_log_may_cause_poison_pr62175_with_nuw_thm (e✝ e✝¹ : IntW 8) :
  mul e✝¹ (shl (const? 4) e✝ { «nsw» := false, «nuw» := true }) ⊑ shl e✝¹ (add e✝ (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_log_may_cause_poison_pr62175_with_nsw_thm (e✝ e✝¹ : IntW 8) :
  mul e✝¹ (shl (const? 4) e✝ { «nsw» := true, «nuw» := false }) ⊑ shl e✝¹ (add e✝ (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


