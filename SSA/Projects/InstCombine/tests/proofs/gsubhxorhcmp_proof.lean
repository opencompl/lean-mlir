
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubhxorhcmp_proof
theorem sext_xor_sub_thm (e✝ : IntW 1) (e✝¹ : IntW 64) :
  sub (LLVM.xor e✝¹ (sext 64 e✝)) (sext 64 e✝) ⊑ select e✝ (sub (const? 0) e✝¹) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_xor_sub_1_thm (e✝ : IntW 64) (e✝¹ : IntW 1) :
  sub (LLVM.xor (sext 64 e✝¹) e✝) (sext 64 e✝¹) ⊑ select e✝¹ (sub (const? 0) e✝) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_xor_sub_2_thm (e✝ : IntW 64) (e✝¹ : IntW 1) :
  sub (sext 64 e✝¹) (LLVM.xor e✝ (sext 64 e✝¹)) ⊑ select e✝¹ e✝ (sub (const? 0) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_xor_sub_3_thm (e✝ : IntW 64) (e✝¹ : IntW 1) :
  sub (sext 64 e✝¹) (LLVM.xor (sext 64 e✝¹) e✝) ⊑ select e✝¹ e✝ (sub (const? 0) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_non_bool_xor_sub_1_thm (e✝ : IntW 64) (e✝¹ : IntW 8) :
  sub (LLVM.xor (sext 64 e✝¹) e✝) (sext 64 e✝¹) ⊑ sub (LLVM.xor e✝ (sext 64 e✝¹)) (sext 64 e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_diff_i1_xor_sub_thm (e✝ e✝¹ : IntW 1) :
  sub (sext 64 e✝¹) (sext 64 e✝) ⊑ add (zext 64 e✝) (sext 64 e✝¹) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_diff_i1_xor_sub_1_thm (e✝ e✝¹ : IntW 1) :
  sub (sext 64 e✝¹) (sext 64 e✝) ⊑ add (zext 64 e✝) (sext 64 e✝¹) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_multi_uses_thm (e✝ : IntW 64) (e✝¹ : IntW 1) (e✝² : IntW 64) :
  add (mul e✝² (sext 64 e✝¹)) (sub (LLVM.xor e✝ (sext 64 e✝¹)) (sext 64 e✝¹)) ⊑
    select e✝¹ (sub (const? 0) (add e✝² e✝)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


