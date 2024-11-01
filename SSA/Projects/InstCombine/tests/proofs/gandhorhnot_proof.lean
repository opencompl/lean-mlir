
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gandhorhnot_proof
theorem and_to_xor1_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.or e✝¹ e✝) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_to_xor2_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))) (LLVM.or e✝¹ e✝) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_to_xor3_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.or e✝¹ e✝) (LLVM.xor (LLVM.and e✝ e✝¹) (const? (-1))) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_to_xor4_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))) (LLVM.or e✝ e✝¹) ⊑ LLVM.xor e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_to_nxor1_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.and e✝¹ e✝) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_to_nxor2_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.and e✝¹ e✝) (LLVM.xor (LLVM.or e✝ e✝¹) (const? (-1))) ⊑
    LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_to_nxor3_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) (LLVM.and e✝¹ e✝) ⊑
    LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_to_nxor4_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) (LLVM.and e✝ e✝¹) ⊑
    LLVM.xor (LLVM.xor e✝ e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_to_xor1_thm (e✝ e✝¹ : IntW 32) : LLVM.xor (LLVM.and e✝¹ e✝) (LLVM.or e✝¹ e✝) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_to_xor2_thm (e✝ e✝¹ : IntW 32) : LLVM.xor (LLVM.and e✝¹ e✝) (LLVM.or e✝ e✝¹) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_to_xor3_thm (e✝ e✝¹ : IntW 32) : LLVM.xor (LLVM.or e✝¹ e✝) (LLVM.and e✝¹ e✝) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_to_xor4_thm (e✝ e✝¹ : IntW 32) : LLVM.xor (LLVM.or e✝¹ e✝) (LLVM.and e✝ e✝¹) ⊑ LLVM.xor e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR32830_thm (e✝ e✝¹ e✝² : IntW 64) :
  LLVM.and (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) (LLVM.or (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑
    LLVM.and (LLVM.or e✝¹ (LLVM.xor e✝² (const? (-1)))) (LLVM.or e✝ (LLVM.xor e✝¹ (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem simplify_or_common_op_commute0_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.and (LLVM.and e✝² e✝¹) e✝) (const? (-1))) e✝² ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem simplify_or_common_op_commute1_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.and (LLVM.and e✝² e✝¹) e✝) (const? (-1))) e✝¹ ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem simplify_or_common_op_commute2_thm (e✝ e✝¹ e✝² e✝³ : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.and (LLVM.and (mul e✝³ e✝³) (LLVM.and e✝² e✝¹)) e✝) (const? (-1))) e✝² ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem simplify_and_common_op_commute1_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.and (LLVM.xor (LLVM.or (LLVM.or e✝² e✝¹) e✝) (const? (-1))) e✝¹ ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem simplify_and_common_op_commute2_thm (e✝ e✝¹ e✝² e✝³ : IntW 4) :
  LLVM.and (LLVM.xor (LLVM.or (LLVM.or (mul e✝³ e✝³) (LLVM.or e✝² e✝¹)) e✝) (const? (-1))) e✝² ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reduce_xor_common_op_commute0_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.xor e✝² e✝¹) e✝) e✝² ⊑ LLVM.or (LLVM.xor e✝¹ e✝) e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reduce_xor_common_op_commute1_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.xor e✝² e✝¹) e✝) e✝¹ ⊑ LLVM.or (LLVM.xor e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem annihilate_xor_common_op_commute2_thm (e✝ e✝¹ e✝² e✝³ : IntW 4) :
  LLVM.xor (LLVM.xor (LLVM.xor (mul e✝³ e✝³) (LLVM.xor e✝² e✝¹)) e✝) e✝² ⊑
    LLVM.xor (LLVM.xor e✝¹ (mul e✝³ e✝³)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


