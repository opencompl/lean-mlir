
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcasthmulhselect_proof
theorem mul_thm (e✝ e✝¹ : IntW 32) :
  zext 32 (mul (trunc 8 e✝¹) (trunc 8 e✝)) ⊑ LLVM.and (mul e✝¹ e✝) (const? 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select1_thm (e✝ e✝¹ e✝² : IntW 32) (e✝³ : IntW 1) :
  zext 32 (select e✝³ (trunc 8 e✝²) (add (trunc 8 e✝¹) (trunc 8 e✝))) ⊑
    LLVM.and (select e✝³ e✝² (add e✝¹ e✝)) (const? 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select2_thm (e✝ e✝¹ e✝² : IntW 8) (e✝³ : IntW 1) :
  trunc 8 (select e✝³ (zext 32 e✝²) (add (zext 32 e✝¹) (zext 32 e✝))) ⊑ select e✝³ e✝² (add e✝¹ e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem foo_thm (e✝ : IntW 1) : e✝ ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


