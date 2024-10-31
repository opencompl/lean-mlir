
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthofhsymmetrichselects_proof
theorem select_of_symmetric_selects_thm (e✝ e✝¹ : IntW 32) (e✝² e✝³ : IntW 1) :
  select e✝³ (select e✝² e✝¹ e✝) (select e✝² e✝ e✝¹) ⊑ select (LLVM.xor e✝² e✝³) e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_of_symmetric_selects_negative1_thm (e✝ e✝¹ : IntW 32) (e✝² e✝³ : IntW 1) :
  select e✝³ (select e✝² e✝¹ e✝) (select e✝³ e✝ e✝¹) ⊑ select e✝³ (select e✝² e✝¹ e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_of_symmetric_selects_commuted_thm (e✝ e✝¹ : IntW 32) (e✝² e✝³ : IntW 1) :
  select e✝³ (select e✝² e✝¹ e✝) (select e✝² e✝ e✝¹) ⊑ select (LLVM.xor e✝² e✝³) e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


