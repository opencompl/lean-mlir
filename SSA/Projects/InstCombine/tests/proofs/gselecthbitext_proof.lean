
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthbitext_proof
theorem sel_sext_constants_thm (e✝ : IntW 1) :
  sext 16 (select e✝ (const? (-1)) (const? 42)) ⊑ select e✝ (const? (-1)) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sel_zext_constants_thm (e✝ : IntW 1) :
  zext 16 (select e✝ (const? (-1)) (const? 42)) ⊑ select e✝ (const? 255) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sel_sext_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  sext 64 (select e✝¹ e✝ (const? 42)) ⊑ select e✝¹ (sext 64 e✝) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sel_zext_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  zext 64 (select e✝¹ e✝ (const? 42)) ⊑ select e✝¹ (zext 64 e✝) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_sel_larger_sext_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  sext 64 (select e✝¹ (trunc 16 e✝) (const? 42)) ⊑ select e✝¹ (sext 64 (trunc 16 e✝)) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_sel_smaller_sext_thm (e✝ : IntW 64) (e✝¹ : IntW 1) :
  sext 32 (select e✝¹ (trunc 16 e✝) (const? 42)) ⊑ select e✝¹ (sext 32 (trunc 16 e✝)) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_sel_equal_sext_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  sext 32 (select e✝¹ (trunc 16 e✝) (const? 42)) ⊑
    select e✝¹ (ashr (shl e✝ (const? 16)) (const? 16)) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_sel_larger_zext_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  zext 64 (select e✝¹ (trunc 16 e✝) (const? 42)) ⊑
    select e✝¹ (zext 64 (LLVM.and e✝ (const? 65535))) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_sel_smaller_zext_thm (e✝ : IntW 64) (e✝¹ : IntW 1) :
  zext 32 (select e✝¹ (trunc 16 e✝) (const? 42)) ⊑
    select e✝¹ (LLVM.and (trunc 32 e✝) (const? 65535)) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_sel_equal_zext_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  zext 32 (select e✝¹ (trunc 16 e✝) (const? 42)) ⊑ select e✝¹ (LLVM.and e✝ (const? 65535)) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sext1_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (sext 32 e✝) (const? 0) ⊑ sext 32 (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sext2_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (const? (-1)) (sext 32 e✝) ⊑ sext 32 (select e✝¹ (const? 1) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sext3_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (const? 0) (sext 32 e✝) ⊑ sext 32 (select (LLVM.xor e✝¹ (const? 1)) e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sext4_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (sext 32 e✝) (const? (-1)) ⊑ sext 32 (select (LLVM.xor e✝¹ (const? 1)) (const? 1) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_zext1_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (zext 32 e✝) (const? 0) ⊑ zext 32 (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_zext2_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (const? 1) (zext 32 e✝) ⊑ zext 32 (select e✝¹ (const? 1) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_zext3_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (const? 0) (zext 32 e✝) ⊑ zext 32 (select (LLVM.xor e✝¹ (const? 1)) e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_zext4_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (zext 32 e✝) (const? 1) ⊑ zext 32 (select (LLVM.xor e✝¹ (const? 1)) (const? 1) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_true_val_must_be_all_ones_thm (e✝ : IntW 1) : select e✝ (sext 32 e✝) (const? 42) ⊑ select e✝ (const? (-1)) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zext_true_val_must_be_one_thm (e✝ : IntW 1) : select e✝ (zext 32 e✝) (const? 42) ⊑ select e✝ (const? 1) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_false_val_must_be_zero_thm (e✝ : IntW 1) : select e✝ (const? 42) (sext 32 e✝) ⊑ select e✝ (const? 42) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zext_false_val_must_be_zero_thm (e✝ : IntW 1) : select e✝ (const? 42) (zext 32 e✝) ⊑ select e✝ (const? 42) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


