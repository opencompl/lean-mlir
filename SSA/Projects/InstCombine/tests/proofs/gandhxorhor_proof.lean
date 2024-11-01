
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gandhxorhor_proof
theorem and_xor_common_op_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.udiv (const? 42) e✝¹) (LLVM.xor (LLVM.udiv (const? 42) e✝¹) (LLVM.udiv (const? 43) e✝)) ⊑
    LLVM.and (LLVM.udiv (const? 42) e✝¹) (LLVM.xor (LLVM.udiv (const? 43) e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_common_op_commute1_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.udiv (const? 42) e✝¹) (LLVM.xor (LLVM.udiv (const? 43) e✝) (LLVM.udiv (const? 42) e✝¹)) ⊑
    LLVM.and (LLVM.udiv (const? 42) e✝¹) (LLVM.xor (LLVM.udiv (const? 43) e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_common_op_commute2_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.udiv (const? 43) e✝¹) (LLVM.udiv (const? 42) e✝)) (LLVM.udiv (const? 42) e✝) ⊑
    LLVM.and (LLVM.udiv (const? 42) e✝) (LLVM.xor (LLVM.udiv (const? 43) e✝¹) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_not_common_op_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor e✝¹ (LLVM.xor e✝ (const? (-1)))) e✝¹ ⊑ LLVM.and e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_xor_common_op_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1))) e✝ ⊑ LLVM.and e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_thm (e✝ e✝¹ : IntW 64) : add (LLVM.and e✝¹ e✝) (LLVM.xor e✝¹ e✝) ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or2_thm (e✝ e✝¹ : IntW 64) : LLVM.or (LLVM.and e✝¹ e✝) (LLVM.xor e✝¹ e✝) ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_or1_thm (e✝ e✝¹ e✝² : IntW 64) :
  LLVM.or (LLVM.xor (LLVM.and (LLVM.udiv (const? 42) e✝²) (LLVM.udiv (const? 42) e✝¹)) (LLVM.udiv (const? 42) e✝))
      (LLVM.udiv (const? 42) e✝¹) ⊑
    LLVM.or (LLVM.udiv (const? 42) e✝) (LLVM.udiv (const? 42) e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_or2_thm (e✝ e✝¹ e✝² : IntW 64) :
  LLVM.or (LLVM.xor (LLVM.and (LLVM.udiv (const? 42) e✝²) (LLVM.udiv (const? 42) e✝¹)) (LLVM.udiv (const? 42) e✝))
      (LLVM.udiv (const? 42) e✝²) ⊑
    LLVM.or (LLVM.udiv (const? 42) e✝) (LLVM.udiv (const? 42) e✝²) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_or3_thm (e✝ e✝¹ e✝² : IntW 64) :
  LLVM.or (LLVM.xor (LLVM.udiv (const? 42) e✝²) (LLVM.and (LLVM.udiv (const? 42) e✝¹) (LLVM.udiv (const? 42) e✝)))
      (LLVM.udiv (const? 42) e✝) ⊑
    LLVM.or (LLVM.udiv (const? 42) e✝²) (LLVM.udiv (const? 42) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_or4_thm (e✝ e✝¹ e✝² : IntW 64) :
  LLVM.or (LLVM.xor (LLVM.udiv (const? 42) e✝²) (LLVM.and (LLVM.udiv (const? 42) e✝¹) (LLVM.udiv (const? 42) e✝)))
      (LLVM.udiv (const? 42) e✝¹) ⊑
    LLVM.or (LLVM.udiv (const? 42) e✝²) (LLVM.udiv (const? 42) e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_or5_thm (e✝ e✝¹ e✝² : IntW 64) :
  LLVM.or (LLVM.udiv (const? 42) e✝²)
      (LLVM.xor (LLVM.and (LLVM.udiv (const? 42) e✝¹) (LLVM.udiv (const? 42) e✝²)) (LLVM.udiv (const? 42) e✝)) ⊑
    LLVM.or (LLVM.udiv (const? 42) e✝²) (LLVM.udiv (const? 42) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_or6_thm (e✝ e✝¹ e✝² : IntW 64) :
  LLVM.or (LLVM.udiv (const? 42) e✝²)
      (LLVM.xor (LLVM.and (LLVM.udiv (const? 42) e✝²) (LLVM.udiv (const? 42) e✝¹)) (LLVM.udiv (const? 42) e✝)) ⊑
    LLVM.or (LLVM.udiv (const? 42) e✝²) (LLVM.udiv (const? 42) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_or7_thm (e✝ e✝¹ e✝² : IntW 64) :
  LLVM.or (LLVM.udiv (const? 42) e✝²)
      (LLVM.xor (LLVM.udiv (const? 42) e✝¹) (LLVM.and (LLVM.udiv (const? 42) e✝) (LLVM.udiv (const? 42) e✝²))) ⊑
    LLVM.or (LLVM.udiv (const? 42) e✝²) (LLVM.udiv (const? 42) e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_xor_or8_thm (e✝ e✝¹ e✝² : IntW 64) :
  LLVM.or (LLVM.udiv (const? 42) e✝²)
      (LLVM.xor (LLVM.udiv (const? 42) e✝¹) (LLVM.and (LLVM.udiv (const? 42) e✝²) (LLVM.udiv (const? 42) e✝))) ⊑
    LLVM.or (LLVM.udiv (const? 42) e✝²) (LLVM.udiv (const? 42) e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_shl_thm (e✝ e✝¹ e✝² e✝³ : IntW 8) :
  LLVM.and (shl e✝³ e✝²) (LLVM.and (shl e✝¹ e✝²) e✝) ⊑ LLVM.and (shl (LLVM.and e✝¹ e✝³) e✝²) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_shl_thm (e✝ e✝¹ e✝² e✝³ : IntW 8) :
  LLVM.or (LLVM.or (shl e✝³ e✝²) e✝¹) (shl e✝ e✝²) ⊑ LLVM.or (shl (LLVM.or e✝³ e✝) e✝²) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_lshr_thm (e✝ e✝¹ e✝² e✝³ : IntW 8) :
  LLVM.or (lshr e✝³ e✝²) (LLVM.or (lshr e✝¹ e✝²) e✝) ⊑ LLVM.or (lshr (LLVM.or e✝¹ e✝³) e✝²) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_lshr_thm (e✝ e✝¹ e✝² e✝³ : IntW 8) :
  LLVM.xor (LLVM.xor (lshr e✝³ e✝²) e✝¹) (lshr e✝ e✝²) ⊑ LLVM.xor (lshr (LLVM.xor e✝³ e✝) e✝²) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_lshr_multiuse_thm (e✝ e✝¹ e✝² e✝³ : IntW 8) :
  LLVM.sdiv (LLVM.xor (lshr e✝³ e✝²) e✝¹) (LLVM.xor (LLVM.xor (lshr e✝³ e✝²) e✝¹) (lshr e✝ e✝²)) ⊑
    LLVM.sdiv (LLVM.xor (lshr e✝³ e✝²) e✝¹) (LLVM.xor (lshr (LLVM.xor e✝³ e✝) e✝²) e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_not_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝¹ (const? (-1)))) (LLVM.xor e✝ (const? (-1))) ⊑
    LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_not_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) (LLVM.xor e✝ (const? (-1))) ⊑
    LLVM.and e✝¹ (LLVM.xor (LLVM.or e✝² e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_not_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝¹ (const? (-1)))) (LLVM.xor e✝ (const? (-1))) ⊑
    LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_not_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) (LLVM.xor e✝ (const? (-1))) ⊑
    LLVM.or e✝¹ (LLVM.xor (LLVM.and e✝² e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.and (LLVM.xor (LLVM.or e✝² e✝) (const? (-1))) e✝¹) ⊑
    LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² (LLVM.sdiv (const? 42) e✝¹)) (const? (-1))) e✝)
      (LLVM.and (LLVM.sdiv (const? 42) e✝¹) (LLVM.xor (LLVM.or e✝² e✝) (const? (-1)))) ⊑
    LLVM.and (LLVM.xor (LLVM.sdiv (const? 42) e✝¹) e✝) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))))
      (LLVM.and (LLVM.xor (LLVM.or e✝¹ (LLVM.sdiv (const? 42) e✝²)) (const? (-1))) e✝) ⊑
    LLVM.and (LLVM.xor e✝ (LLVM.sdiv (const? 42) e✝²)) (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.and (LLVM.xor (LLVM.or e✝ e✝¹) (const? (-1))) e✝²) ⊑
    LLVM.and (LLVM.xor e✝² e✝) (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_commute4_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))))
      (LLVM.and (LLVM.xor (LLVM.or e✝¹ (LLVM.sdiv (const? 42) e✝²)) (const? (-1))) e✝) ⊑
    LLVM.and (LLVM.xor e✝ (LLVM.sdiv (const? 42) e✝²)) (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_commute5_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.or (LLVM.sdiv (const? 42) e✝¹) e✝) (const? (-1))))
      (LLVM.and (LLVM.xor (LLVM.or (LLVM.sdiv (const? 42) e✝¹) (LLVM.sdiv (const? 42) e✝²)) (const? (-1))) e✝) ⊑
    LLVM.and (LLVM.xor e✝ (LLVM.sdiv (const? 42) e✝²)) (LLVM.xor (LLVM.sdiv (const? 42) e✝¹) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_commute6_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.and (LLVM.xor (LLVM.or e✝ e✝²) (const? (-1))) e✝¹) ⊑
    LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_commute7_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.and (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) e✝²) ⊑
    LLVM.and (LLVM.xor e✝² e✝) (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_commute8_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.sdiv (const? 42) e✝¹)) (const? (-1))) e✝)
      (LLVM.and (LLVM.sdiv (const? 42) e✝¹) (LLVM.xor (LLVM.or e✝ (LLVM.sdiv (const? 42) e✝²)) (const? (-1)))) ⊑
    LLVM.and (LLVM.xor (LLVM.sdiv (const? 42) e✝¹) e✝) (LLVM.xor (LLVM.sdiv (const? 42) e✝²) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_commute9_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or
      (LLVM.and (LLVM.xor (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.sdiv (const? 42) e✝¹)) (const? (-1)))
        (LLVM.sdiv (const? 42) e✝))
      (LLVM.and (LLVM.sdiv (const? 42) e✝¹)
        (LLVM.xor (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.sdiv (const? 42) e✝)) (const? (-1)))) ⊑
    LLVM.and (LLVM.xor (LLVM.sdiv (const? 42) e✝¹) (LLVM.sdiv (const? 42) e✝))
      (LLVM.xor (LLVM.sdiv (const? 42) e✝²) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_wrong_c_thm (e✝ e✝¹ e✝² e✝³ : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝³ e✝²) (const? (-1))) e✝¹)
      (LLVM.and (LLVM.xor (LLVM.or e✝³ e✝) (const? (-1))) e✝²) ⊑
    LLVM.or (LLVM.and e✝¹ (LLVM.xor (LLVM.or e✝³ e✝²) (const? (-1))))
      (LLVM.and e✝² (LLVM.xor (LLVM.or e✝³ e✝) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_wrong_b_thm (e✝ e✝¹ e✝² e✝³ : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝³ e✝²) (const? (-1))) e✝¹)
      (LLVM.and (LLVM.xor (LLVM.or e✝³ e✝¹) (const? (-1))) e✝) ⊑
    LLVM.or (LLVM.and e✝¹ (LLVM.xor (LLVM.or e✝³ e✝²) (const? (-1))))
      (LLVM.and e✝ (LLVM.xor (LLVM.or e✝³ e✝¹) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.or (LLVM.xor (LLVM.and e✝² e✝) (const? (-1))) e✝¹) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝¹ e✝) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² (LLVM.sdiv (const? 42) e✝¹)) (const? (-1))) e✝)
      (LLVM.or (LLVM.sdiv (const? 42) e✝¹) (LLVM.xor (LLVM.and e✝² e✝) (const? (-1)))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor (LLVM.sdiv (const? 42) e✝¹) e✝) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))))
      (LLVM.or (LLVM.xor (LLVM.and e✝¹ (LLVM.sdiv (const? 42) e✝²)) (const? (-1))) e✝) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝ (LLVM.sdiv (const? 42) e✝²)) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.or (LLVM.xor (LLVM.and e✝ e✝¹) (const? (-1))) e✝²) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝² e✝) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_commute4_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))))
      (LLVM.or (LLVM.xor (LLVM.and e✝¹ (LLVM.sdiv (const? 42) e✝²)) (const? (-1))) e✝) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝ (LLVM.sdiv (const? 42) e✝²)) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_commute5_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝¹) e✝) (const? (-1))))
      (LLVM.or (LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝¹) (LLVM.sdiv (const? 42) e✝²)) (const? (-1))) e✝) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝ (LLVM.sdiv (const? 42) e✝²)) (LLVM.sdiv (const? 42) e✝¹)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_commute6_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.or (LLVM.xor (LLVM.and e✝ e✝²) (const? (-1))) e✝¹) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝¹ e✝) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_commute7_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.or (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))) e✝²) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝² e✝) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_commute8_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.sdiv (const? 42) e✝¹)) (const? (-1))) e✝)
      (LLVM.or (LLVM.sdiv (const? 42) e✝¹) (LLVM.xor (LLVM.and e✝ (LLVM.sdiv (const? 42) e✝²)) (const? (-1)))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor (LLVM.sdiv (const? 42) e✝¹) e✝) (LLVM.sdiv (const? 42) e✝²)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_commute9_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and
      (LLVM.or (LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.sdiv (const? 42) e✝¹)) (const? (-1)))
        (LLVM.sdiv (const? 42) e✝))
      (LLVM.or (LLVM.sdiv (const? 42) e✝¹)
        (LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.sdiv (const? 42) e✝)) (const? (-1)))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor (LLVM.sdiv (const? 42) e✝¹) (LLVM.sdiv (const? 42) e✝)) (LLVM.sdiv (const? 42) e✝²))
      (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_wrong_c_thm (e✝ e✝¹ e✝² e✝³ : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝³ e✝²) (const? (-1))) e✝¹)
      (LLVM.or (LLVM.xor (LLVM.and e✝³ e✝) (const? (-1))) e✝²) ⊑
    LLVM.and (LLVM.or e✝¹ (LLVM.xor (LLVM.and e✝³ e✝²) (const? (-1))))
      (LLVM.or e✝² (LLVM.xor (LLVM.and e✝³ e✝) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_wrong_b_thm (e✝ e✝¹ e✝² e✝³ : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝³ e✝²) (const? (-1))) e✝¹)
      (LLVM.or (LLVM.xor (LLVM.and e✝³ e✝¹) (const? (-1))) e✝) ⊑
    LLVM.and (LLVM.or e✝¹ (LLVM.xor (LLVM.and e✝³ e✝²) (const? (-1))))
      (LLVM.or e✝ (LLVM.xor (LLVM.and e✝³ e✝¹) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_not_not_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝) (LLVM.xor (LLVM.or e✝ e✝²) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e✝¹ e✝) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_not_not_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))))
      (LLVM.xor (LLVM.or (LLVM.sdiv (const? 42) e✝²) e✝¹) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e✝ (LLVM.sdiv (const? 42) e✝²)) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_not_not_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝) (LLVM.xor (LLVM.or e✝ e✝²) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e✝¹ e✝) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_not_not_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝) (LLVM.xor (LLVM.or e✝ e✝¹) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e✝² e✝) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_not_not_commute4_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝) (LLVM.xor (LLVM.or e✝² e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e✝¹ e✝) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_not_not_commute5_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) (LLVM.and (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) e✝²) ⊑
    LLVM.xor (LLVM.or (LLVM.and e✝ e✝²) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_not_not_commute6_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))))
      (LLVM.xor (LLVM.or (LLVM.sdiv (const? 42) e✝²) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e✝¹ (LLVM.sdiv (const? 42) e✝²)) e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_not_not_commute7_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.and e✝² e✝) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_not_not_wrong_a_thm (e✝ e✝¹ e✝² e✝³ : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝³ e✝²) (const? (-1))) e✝¹) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) ⊑
    LLVM.or (LLVM.and e✝¹ (LLVM.xor (LLVM.or e✝³ e✝²) (const? (-1)))) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_not_not_wrong_b_thm (e✝ e✝¹ e✝² e✝³ : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝³ e✝²) (const? (-1))) e✝¹) (LLVM.xor (LLVM.or e✝ e✝³) (const? (-1))) ⊑
    LLVM.or (LLVM.and e✝¹ (LLVM.xor (LLVM.or e✝³ e✝²) (const? (-1)))) (LLVM.xor (LLVM.or e✝ e✝³) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or_not_not_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝) (LLVM.xor (LLVM.and e✝ e✝²) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝¹ e✝) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or_not_not_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))))
      (LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝²) e✝¹) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝ (LLVM.sdiv (const? 42) e✝²)) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or_not_not_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝) (LLVM.xor (LLVM.and e✝ e✝²) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝¹ e✝) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or_not_not_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝) (LLVM.xor (LLVM.and e✝ e✝¹) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝² e✝) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or_not_not_commute4_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝) (LLVM.xor (LLVM.and e✝² e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝¹ e✝) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or_not_not_commute5_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) (LLVM.or (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))) e✝²) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝ e✝²) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or_not_not_commute6_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))))
      (LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝²) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝¹ (LLVM.sdiv (const? 42) e✝²)) e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or_not_not_commute7_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝² e✝) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or_not_not_wrong_a_thm (e✝ e✝¹ e✝² e✝³ : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝³ e✝²) (const? (-1))) e✝¹) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.and e✝¹ e✝) (LLVM.or e✝¹ (LLVM.xor (LLVM.and e✝³ e✝²) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or_not_not_wrong_b_thm (e✝ e✝¹ e✝² e✝³ : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝³ e✝²) (const? (-1))) e✝¹) (LLVM.xor (LLVM.and e✝ e✝³) (const? (-1))) ⊑
    LLVM.and (LLVM.or e✝¹ (LLVM.xor (LLVM.and e✝³ e✝²) (const? (-1))))
      (LLVM.xor (LLVM.and e✝ e✝³) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_or_not_or_xor_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.xor (LLVM.or (LLVM.xor e✝² e✝¹) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝² e✝¹) (LLVM.or (LLVM.xor e✝² e✝¹) e✝)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_or_not_or_xor_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.xor (LLVM.or (LLVM.xor e✝¹ e✝²) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝² e✝¹) (LLVM.or (LLVM.xor e✝¹ e✝²) e✝)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_or_not_or_xor_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))))
      (LLVM.xor (LLVM.or (LLVM.xor e✝¹ e✝) (LLVM.sdiv (const? 42) e✝²)) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝¹ e✝) (LLVM.or (LLVM.xor e✝¹ e✝) (LLVM.sdiv (const? 42) e✝²))) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_or_not_or_xor_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.xor (LLVM.or (LLVM.xor e✝¹ e✝²) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝² e✝¹) (LLVM.or (LLVM.xor e✝¹ e✝²) e✝)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_or_not_or_xor_commute4_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))))
      (LLVM.xor (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝¹ e✝)) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝¹ e✝) (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝¹ e✝))) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_not_or_or_not_or_xor_commute5_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or (LLVM.xor e✝² e✝¹) e✝) (const? (-1)))
      (LLVM.and (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) e✝) ⊑
    LLVM.xor (LLVM.and (LLVM.or e✝² e✝¹) (LLVM.or (LLVM.xor e✝² e✝¹) e✝)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_and_not_and_xor_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) e✝) (LLVM.or e✝ (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_and_not_and_xor_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.xor (LLVM.and (LLVM.xor e✝¹ e✝²) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝¹ e✝²) e✝) (LLVM.or e✝ (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_and_not_and_xor_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))))
      (LLVM.xor (LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.sdiv (const? 42) e✝²)) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.sdiv (const? 42) e✝²))
      (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_and_not_and_xor_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝)
      (LLVM.xor (LLVM.and (LLVM.xor e✝¹ e✝²) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝¹ e✝²) e✝) (LLVM.or e✝ (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_and_not_and_xor_commute4_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))))
      (LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝¹ e✝)) (const? (-1))) ⊑
    LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝¹ e✝))
      (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_and_and_not_and_xor_commute5_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) e✝) (const? (-1)))
      (LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) e✝) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) e✝) (LLVM.or e✝ (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_not_or_or_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) e✝)
      (LLVM.xor (LLVM.or (LLVM.or e✝¹ e✝²) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e✝ e✝¹) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_not_or_or_commute1_or_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) e✝)
      (LLVM.xor (LLVM.or (LLVM.or e✝ e✝²) e✝¹) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e✝ e✝¹) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_not_or_or_commute2_or_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) e✝)
      (LLVM.xor (LLVM.or (LLVM.or e✝¹ e✝) e✝²) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e✝ e✝¹) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_not_or_or_commute1_and_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) e✝)
      (LLVM.xor (LLVM.or (LLVM.or e✝ e✝²) e✝¹) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e✝ e✝¹) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_not_or_or_commute2_and_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and e✝² e✝¹) (LLVM.xor e✝ (const? (-1))))
      (LLVM.xor (LLVM.or (LLVM.or e✝² e✝) e✝¹) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e✝² e✝¹) e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_not_or_or_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) e✝)
      (LLVM.xor (LLVM.or (LLVM.or e✝² e✝¹) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e✝ e✝¹) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_not_or_or_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) (LLVM.sdiv (const? 42) e✝))
      (LLVM.xor (LLVM.or (LLVM.sdiv (const? 42) e✝) (LLVM.or e✝¹ e✝²)) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor (LLVM.sdiv (const? 42) e✝) e✝¹) e✝²) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_not_or_or_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝¹ (const? (-1)))) e✝)
      (LLVM.xor (LLVM.or (LLVM.or (LLVM.sdiv (const? 42) e✝²) e✝¹) e✝) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor e✝ (LLVM.sdiv (const? 42) e✝²)) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_not_or_or_commute4_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.and (LLVM.xor e✝¹ (const? (-1))) e✝))
      (LLVM.xor (LLVM.or (LLVM.or e✝ e✝¹) (LLVM.sdiv (const? 42) e✝²)) (const? (-1))) ⊑
    LLVM.xor (LLVM.or (LLVM.xor (LLVM.sdiv (const? 42) e✝²) e✝) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_not_and_and_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) e✝)
      (LLVM.xor (LLVM.and (LLVM.and e✝¹ e✝²) e✝) (const? (-1))) ⊑
    LLVM.or (LLVM.xor e✝ e✝¹) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_not_and_and_commute1_and_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) e✝)
      (LLVM.xor (LLVM.and (LLVM.and e✝ e✝²) e✝¹) (const? (-1))) ⊑
    LLVM.or (LLVM.xor e✝ e✝¹) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_not_and_and_commute2_and_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) e✝)
      (LLVM.xor (LLVM.and (LLVM.and e✝¹ e✝) e✝²) (const? (-1))) ⊑
    LLVM.or (LLVM.xor e✝ e✝¹) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_not_and_and_commute1_or_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) e✝)
      (LLVM.xor (LLVM.and (LLVM.and e✝ e✝²) e✝¹) (const? (-1))) ⊑
    LLVM.or (LLVM.xor e✝ e✝¹) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_not_and_and_commute2_or_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or e✝² e✝¹) (LLVM.xor e✝ (const? (-1))))
      (LLVM.xor (LLVM.and (LLVM.and e✝² e✝) e✝¹) (const? (-1))) ⊑
    LLVM.or (LLVM.xor e✝² e✝¹) (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_not_and_and_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) e✝)
      (LLVM.xor (LLVM.and (LLVM.and e✝² e✝¹) e✝) (const? (-1))) ⊑
    LLVM.or (LLVM.xor e✝ e✝¹) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_not_and_and_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) (LLVM.sdiv (const? 42) e✝))
      (LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝) (LLVM.and e✝¹ e✝²)) (const? (-1))) ⊑
    LLVM.or (LLVM.xor (LLVM.sdiv (const? 42) e✝) e✝¹) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_not_and_and_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝¹ (const? (-1)))) e✝)
      (LLVM.xor (LLVM.and (LLVM.and (LLVM.sdiv (const? 42) e✝²) e✝¹) e✝) (const? (-1))) ⊑
    LLVM.or (LLVM.xor e✝ (LLVM.sdiv (const? 42) e✝²)) (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_not_and_and_commute4_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.or (LLVM.xor e✝¹ (const? (-1))) e✝))
      (LLVM.xor (LLVM.and (LLVM.and e✝ e✝¹) (LLVM.sdiv (const? 42) e✝²)) (const? (-1))) ⊑
    LLVM.or (LLVM.xor (LLVM.sdiv (const? 42) e✝²) e✝) (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_no_or_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) e✝) (LLVM.xor (LLVM.or e✝¹ e✝²) (const? (-1))) ⊑
    LLVM.and (LLVM.or e✝ (LLVM.xor e✝¹ (const? (-1)))) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_no_or_commute1_and_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and e✝² e✝¹) (LLVM.xor e✝ (const? (-1)))) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) ⊑
    LLVM.and (LLVM.or e✝² (LLVM.xor e✝¹ (const? (-1)))) (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_no_or_commute2_and_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) e✝) (LLVM.xor (LLVM.or e✝ e✝²) (const? (-1))) ⊑
    LLVM.and (LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1)))) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_no_or_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) e✝) (LLVM.xor (LLVM.or e✝² e✝¹) (const? (-1))) ⊑
    LLVM.and (LLVM.or e✝ (LLVM.xor e✝¹ (const? (-1)))) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_no_or_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝¹ (const? (-1)))) e✝)
      (LLVM.xor (LLVM.or (LLVM.sdiv (const? 42) e✝²) e✝¹) (const? (-1))) ⊑
    LLVM.and (LLVM.or e✝ (LLVM.xor (LLVM.sdiv (const? 42) e✝²) (const? (-1)))) (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_and_and_or_no_or_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.and (LLVM.xor e✝¹ (const? (-1))) e✝))
      (LLVM.xor (LLVM.or e✝ e✝¹) (const? (-1))) ⊑
    LLVM.and (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝ (const? (-1)))) (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_no_and_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) e✝) (LLVM.xor (LLVM.and e✝¹ e✝²) (const? (-1))) ⊑
    LLVM.or (LLVM.and e✝ (LLVM.xor e✝¹ (const? (-1)))) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_no_and_commute1_or_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or e✝² e✝¹) (LLVM.xor e✝ (const? (-1)))) (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))) ⊑
    LLVM.or (LLVM.and e✝² (LLVM.xor e✝¹ (const? (-1)))) (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_no_and_commute2_or_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) e✝) (LLVM.xor (LLVM.and e✝ e✝²) (const? (-1))) ⊑
    LLVM.or (LLVM.and e✝¹ (LLVM.xor e✝ (const? (-1)))) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_no_and_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) e✝) (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) ⊑
    LLVM.or (LLVM.and e✝ (LLVM.xor e✝¹ (const? (-1)))) (LLVM.xor e✝² (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_no_and_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝¹ (const? (-1)))) e✝)
      (LLVM.xor (LLVM.and (LLVM.sdiv (const? 42) e✝²) e✝¹) (const? (-1))) ⊑
    LLVM.or (LLVM.and e✝ (LLVM.xor (LLVM.sdiv (const? 42) e✝²) (const? (-1)))) (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_or_and_no_and_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.sdiv (const? 42) e✝²) (LLVM.or (LLVM.xor e✝¹ (const? (-1))) e✝))
      (LLVM.xor (LLVM.and e✝ e✝¹) (const? (-1))) ⊑
    LLVM.or (LLVM.and (LLVM.sdiv (const? 42) e✝²) (LLVM.xor e✝ (const? (-1)))) (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_orn_xor_thm (e✝ e✝¹ : IntW 4) :
  LLVM.and (LLVM.or (LLVM.xor e✝¹ (const? (-1))) e✝) (LLVM.xor e✝¹ e✝) ⊑
    LLVM.and e✝ (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_orn_xor_commute8_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor (mul e✝¹ e✝¹) (mul e✝ e✝)) (LLVM.or (mul e✝¹ e✝¹) (LLVM.xor (mul e✝ e✝) (const? (-1)))) ⊑
    LLVM.and (mul e✝¹ e✝¹) (LLVM.xor (mul e✝ e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_zext_thm (e✝ : IntW 4) (e✝¹ : IntW 8) :
  LLVM.and (zext 16 e✝¹) (zext 16 e✝) ⊑ zext 16 (LLVM.and e✝¹ (zext 8 e✝)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_zext_zext_thm (e✝ : IntW 8) (e✝¹ : IntW 4) :
  LLVM.or (zext 16 e✝¹) (zext 16 e✝) ⊑ zext 16 (LLVM.or e✝ (zext 8 e✝¹)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_sext_sext_thm (e✝ : IntW 8) (e✝¹ : IntW 4) :
  LLVM.and (sext 16 e✝¹) (sext 16 e✝) ⊑ sext 16 (LLVM.and e✝ (sext 8 e✝¹)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_sext_sext_thm (e✝ : IntW 4) (e✝¹ : IntW 8) :
  LLVM.or (sext 16 e✝¹) (sext 16 e✝) ⊑ sext 16 (LLVM.or e✝¹ (sext 8 e✝)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_sext_sext_thm (e✝ : IntW 4) (e✝¹ : IntW 8) :
  LLVM.xor (sext 16 e✝¹) (sext 16 e✝) ⊑ sext 16 (LLVM.xor e✝¹ (sext 8 e✝)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem canonicalize_logic_first_or0_thm (e✝ : IntW 32) :
  LLVM.or (add e✝ (const? 112)) (const? 15) ⊑ add (LLVM.or e✝ (const? 15)) (const? 112) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem canonicalize_logic_first_or0_nsw_thm (e✝ : IntW 32) :
  LLVM.or (add e✝ (const? 112) { «nsw» := true, «nuw» := false }) (const? 15) ⊑
    add (LLVM.or e✝ (const? 15)) (const? 112) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem canonicalize_logic_first_or0_nswnuw_thm (e✝ : IntW 32) :
  LLVM.or (add e✝ (const? 112) { «nsw» := true, «nuw» := true }) (const? 15) ⊑
    add (LLVM.or e✝ (const? 15)) (const? 112) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem canonicalize_logic_first_and0_thm (e✝ : IntW 8) :
  LLVM.and (add e✝ (const? 48)) (const? (-10)) ⊑ add (LLVM.and e✝ (const? (-10))) (const? 48) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem canonicalize_logic_first_and0_nsw_thm (e✝ : IntW 8) :
  LLVM.and (add e✝ (const? 48) { «nsw» := true, «nuw» := false }) (const? (-10)) ⊑
    add (LLVM.and e✝ (const? (-10))) (const? 48) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem canonicalize_logic_first_and0_nswnuw_thm (e✝ : IntW 8) :
  LLVM.and (add e✝ (const? 48) { «nsw» := true, «nuw» := true }) (const? (-10)) ⊑
    add (LLVM.and e✝ (const? (-10))) (const? 48) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem canonicalize_logic_first_xor_0_thm (e✝ : IntW 8) :
  LLVM.xor (add e✝ (const? 96)) (const? 31) ⊑ add (LLVM.xor e✝ (const? 31)) (const? 96) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem canonicalize_logic_first_xor_0_nsw_thm (e✝ : IntW 8) :
  LLVM.xor (add e✝ (const? 96) { «nsw» := true, «nuw» := false }) (const? 31) ⊑
    add (LLVM.xor e✝ (const? 31)) (const? 96) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem canonicalize_logic_first_xor_0_nswnuw_thm (e✝ : IntW 8) :
  LLVM.xor (add e✝ (const? 96) { «nsw» := true, «nuw» := true }) (const? 31) ⊑
    add (LLVM.xor e✝ (const? 31)) (const? 96) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


