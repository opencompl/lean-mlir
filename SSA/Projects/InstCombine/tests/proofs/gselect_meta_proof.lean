
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselect_meta_proof
theorem shrink_select_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  trunc 8 (select e✝¹ e✝ (const? 42)) ⊑ select e✝¹ (trunc 8 e✝) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_cond_thm (e✝ e✝¹ : IntW 32) (e✝² : IntW 1) :
  select (LLVM.xor e✝² (const? 1)) e✝¹ e✝ ⊑ select e✝² e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_add_thm (e✝ e✝¹ : IntW 64) (e✝² : IntW 1) :
  select e✝² (add e✝¹ e✝) e✝¹ ⊑ add e✝¹ (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_sub_thm (e✝ e✝¹ : IntW 17) (e✝² : IntW 1) :
  select e✝² (sub e✝¹ e✝) e✝¹ ⊑ sub e✝¹ (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_ashr_thm (e✝ e✝¹ : IntW 128) (e✝² : IntW 1) :
  select e✝² (ashr e✝¹ e✝) e✝¹ ⊑ ashr e✝¹ (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


