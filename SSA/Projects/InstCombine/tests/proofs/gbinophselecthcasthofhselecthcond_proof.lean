
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gbinophselecthcasthofhselecthcond_proof
theorem add_select_zext_thm (e✝ : IntW 1) :
  add (select e✝ (const? 64) (const? 1)) (zext 64 e✝) ⊑ select e✝ (const? 65) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_select_sext_thm (e✝ : IntW 1) :
  add (select e✝ (const? 64) (const? 1)) (sext 64 e✝) ⊑ select e✝ (const? 63) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_select_not_zext_thm (e✝ : IntW 1) :
  add (select e✝ (const? 64) (const? 1)) (zext 64 (LLVM.xor e✝ (const? 1))) ⊑ select e✝ (const? 64) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_select_not_sext_thm (e✝ : IntW 1) :
  add (select e✝ (const? 64) (const? 1)) (sext 64 (LLVM.xor e✝ (const? 1))) ⊑ select e✝ (const? 64) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_select_sext_thm (e✝ : IntW 64) (e✝¹ : IntW 1) :
  sub (select e✝¹ (const? 64) e✝) (sext 64 e✝¹) ⊑ select e✝¹ (const? 65) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_select_not_zext_thm (e✝ : IntW 64) (e✝¹ : IntW 1) :
  sub (select e✝¹ e✝ (const? 64)) (zext 64 (LLVM.xor e✝¹ (const? 1))) ⊑ select e✝¹ e✝ (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_select_not_sext_thm (e✝ : IntW 64) (e✝¹ : IntW 1) :
  sub (select e✝¹ e✝ (const? 64)) (sext 64 (LLVM.xor e✝¹ (const? 1))) ⊑ select e✝¹ e✝ (const? 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_select_zext_thm (e✝ : IntW 64) (e✝¹ : IntW 1) :
  mul (select e✝¹ e✝ (const? 1)) (zext 64 e✝¹) ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_select_sext_thm (e✝ : IntW 1) :
  mul (select e✝ (const? 64) (const? 1)) (sext 64 e✝) ⊑ select e✝ (const? (-64)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_zext_different_condition_thm (e✝ e✝¹ : IntW 1) :
  add (select e✝¹ (const? 64) (const? 1)) (zext 64 e✝) ⊑
    add (select e✝¹ (const? 64) (const? 1)) (zext 64 e✝) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem multiuse_add_thm (e✝ : IntW 1) :
  add (add (select e✝ (const? 64) (const? 1)) (zext 64 e✝)) (const? 1) ⊑ select e✝ (const? 66) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem multiuse_select_thm (e✝ : IntW 1) :
  mul (select e✝ (const? 64) (const? 0)) (sub (select e✝ (const? 64) (const? 0)) (zext 64 e✝)) ⊑
    select e✝ (const? 4032) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_non_const_sides_thm (e✝ e✝¹ : IntW 64) (e✝² : IntW 1) :
  sub (select e✝² e✝¹ e✝) (zext 64 e✝²) ⊑ select e✝² (add e✝¹ (const? (-1))) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_select_sext_op_swapped_non_const_args_thm (e✝ e✝¹ : IntW 6) (e✝² : IntW 1) :
  sub (sext 6 e✝²) (select e✝² e✝¹ e✝) ⊑ select e✝² (LLVM.xor e✝¹ (const? (-1))) (sub (const? 0) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_select_zext_op_swapped_non_const_args_thm (e✝ e✝¹ : IntW 6) (e✝² : IntW 1) :
  sub (zext 6 e✝²) (select e✝² e✝¹ e✝) ⊑ select e✝² (sub (const? 1) e✝¹) (sub (const? 0) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


