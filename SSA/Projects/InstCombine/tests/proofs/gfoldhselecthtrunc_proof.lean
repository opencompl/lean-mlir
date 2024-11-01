
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gfoldhselecthtrunc_proof
theorem fold_select_trunc_nuw_true_thm (e✝ e✝¹ : IntW 8) : select (trunc 1 e✝¹) e✝¹ e✝ ⊑ select (trunc 1 e✝¹) (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_select_trunc_nuw_false_thm (e✝ e✝¹ : IntW 8) : select (trunc 1 e✝¹) e✝ e✝¹ ⊑ select (trunc 1 e✝¹) e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_select_trunc_nsw_true_thm (e✝ e✝¹ : IntW 128) : select (trunc 1 e✝¹) e✝¹ e✝ ⊑ select (trunc 1 e✝¹) (const? (-1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_select_trunc_nsw_false_thm (e✝ e✝¹ : IntW 8) : select (trunc 1 e✝¹) e✝ e✝¹ ⊑ select (trunc 1 e✝¹) e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


