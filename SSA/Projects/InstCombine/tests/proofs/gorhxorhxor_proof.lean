
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gorhxorhxor_proof
theorem or_xor_xor_normal_variant1_thm (e✝ e✝¹ : IntW 1) :
  LLVM.or (LLVM.xor (LLVM.and e✝¹ e✝) e✝¹) (LLVM.xor (LLVM.and e✝¹ e✝) e✝) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_xor_normal_variant2_thm (e✝ e✝¹ : IntW 8) :
  LLVM.or (LLVM.xor (LLVM.and e✝¹ e✝) e✝) (LLVM.xor e✝¹ (LLVM.and e✝¹ e✝)) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_xor_normal_variant3_thm (e✝ e✝¹ : IntW 16) :
  LLVM.or (LLVM.xor e✝¹ (LLVM.and e✝¹ e✝)) (LLVM.xor e✝ (LLVM.and e✝¹ e✝)) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_xor_normal_variant4_thm (e✝ e✝¹ : IntW 64) :
  LLVM.or (LLVM.xor (LLVM.and e✝¹ e✝) e✝¹) (LLVM.xor (LLVM.and e✝¹ e✝) e✝) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_xor_normal_binops_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor e✝² e✝¹) (LLVM.and (LLVM.xor e✝² e✝¹) (LLVM.xor e✝ e✝¹)))
      (LLVM.xor (LLVM.xor e✝ e✝¹) (LLVM.and (LLVM.xor e✝² e✝¹) (LLVM.xor e✝ e✝¹))) ⊑
    LLVM.xor e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


