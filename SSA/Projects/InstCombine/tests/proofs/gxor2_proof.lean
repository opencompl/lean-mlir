
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gxor2_proof
theorem test2_thm (e✝ : IntW 32) :
  LLVM.xor (add (LLVM.and e✝ (const? 32)) (const? 145)) (const? 153) ⊑
    LLVM.or (LLVM.and e✝ (const? 32)) (const? 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e✝ : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.or e✝ (const? 145)) (const? 177)) (const? 153) ⊑
    LLVM.or (LLVM.and e✝ (const? 32)) (const? 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e✝ : IntW 32) :
  add (LLVM.xor (lshr (LLVM.xor e✝ (const? 1234)) (const? 8)) (const? 1)) (LLVM.xor e✝ (const? 1234)) ⊑
    add (LLVM.xor (lshr e✝ (const? 8)) (const? 5)) (LLVM.xor e✝ (const? 1234)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm (e✝ : IntW 32) :
  add (lshr (LLVM.xor e✝ (const? 1234)) (const? 16)) (LLVM.xor e✝ (const? 1234)) ⊑
    add (lshr e✝ (const? 16)) (LLVM.xor e✝ (const? 1234)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.or e✝¹ e✝) (LLVM.xor e✝¹ (const? (-1))) ⊑ LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.xor e✝¹ (const? (-1))) (LLVM.or e✝¹ e✝) ⊑ LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm (e✝ e✝¹ : IntW 32) : LLVM.xor (LLVM.and e✝¹ e✝) (LLVM.xor e✝¹ e✝) ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9b_thm (e✝ e✝¹ : IntW 32) : LLVM.xor (LLVM.and e✝¹ e✝) (LLVM.xor e✝ e✝¹) ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm (e✝ e✝¹ : IntW 32) : LLVM.xor (LLVM.xor e✝¹ e✝) (LLVM.and e✝¹ e✝) ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10b_thm (e✝ e✝¹ : IntW 32) : LLVM.xor (LLVM.xor e✝¹ e✝) (LLVM.and e✝ e✝¹) ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝ (const? (-1))) e✝¹) ⊑
    LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝ e✝¹) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11b_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e✝¹ (const? (-1))) e✝) (LLVM.xor e✝ e✝¹) ⊑
    LLVM.and (LLVM.xor e✝ e✝¹) (LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11c_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑
    LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11d_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e✝¹ (const? (-1))) e✝) (LLVM.xor e✝¹ e✝) ⊑
    LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11e_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.xor (mul e✝² e✝¹) e✝) (LLVM.xor (mul e✝² e✝¹) (LLVM.xor e✝ (const? (-1)))) ⊑
    LLVM.and (LLVM.xor (mul e✝² e✝¹) e✝) (LLVM.xor (LLVM.xor e✝ (mul e✝² e✝¹)) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11f_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.xor (mul e✝² e✝¹) (LLVM.xor e✝ (const? (-1)))) (LLVM.xor (mul e✝² e✝¹) e✝) ⊑
    LLVM.and (LLVM.xor (mul e✝² e✝¹) e✝) (LLVM.xor (LLVM.xor e✝ (mul e✝² e✝¹)) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.and e✝¹ (LLVM.xor e✝ (const? (-1)))) (LLVM.xor e✝¹ (const? (-1))) ⊑
    LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12commuted_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e✝¹ (const? (-1))) e✝) (LLVM.xor e✝ (const? (-1))) ⊑
    LLVM.xor (LLVM.and e✝ e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.xor e✝¹ (const? (-1))) (LLVM.and e✝¹ (LLVM.xor e✝ (const? (-1)))) ⊑
    LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13commuted_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.xor e✝¹ (const? (-1))) (LLVM.and (LLVM.xor e✝ (const? (-1))) e✝¹) ⊑
    LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or_xor_common_op_commute1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.xor (LLVM.xor e✝² e✝¹) (LLVM.or e✝² e✝) ⊑ LLVM.xor (LLVM.and e✝ (LLVM.xor e✝² (const? (-1)))) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or_xor_common_op_commute2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.xor (LLVM.xor e✝² e✝¹) (LLVM.or e✝¹ e✝) ⊑ LLVM.xor (LLVM.and e✝ (LLVM.xor e✝¹ (const? (-1)))) e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or_xor_common_op_commute3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.xor (LLVM.xor e✝² e✝¹) (LLVM.or e✝ e✝²) ⊑ LLVM.xor (LLVM.and e✝ (LLVM.xor e✝² (const? (-1)))) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or_xor_common_op_commute4_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.xor (LLVM.xor e✝² e✝¹) (LLVM.or e✝ e✝¹) ⊑ LLVM.xor (LLVM.and e✝ (LLVM.xor e✝¹ (const? (-1)))) e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or_xor_common_op_commute5_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.xor (LLVM.or e✝² e✝¹) (LLVM.xor e✝² e✝) ⊑ LLVM.xor (LLVM.and e✝¹ (LLVM.xor e✝² (const? (-1)))) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or_xor_common_op_commute6_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.xor (LLVM.or e✝² e✝¹) (LLVM.xor e✝ e✝²) ⊑ LLVM.xor (LLVM.and e✝¹ (LLVM.xor e✝² (const? (-1)))) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or_xor_common_op_commute7_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.xor (LLVM.or e✝² e✝¹) (LLVM.xor e✝¹ e✝) ⊑ LLVM.xor (LLVM.and e✝² (LLVM.xor e✝¹ (const? (-1)))) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or_xor_common_op_commute8_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.xor (LLVM.or e✝² e✝¹) (LLVM.xor e✝ e✝¹) ⊑ LLVM.xor (LLVM.and e✝² (LLVM.xor e✝¹ (const? (-1)))) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15_thm (e✝ e✝¹ : IntW 8) :
  mul (LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝ (const? 33)) e✝¹)) (LLVM.xor (LLVM.xor e✝ (const? 33)) e✝¹) ⊑
    mul (LLVM.and (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝ e✝¹) (const? 33)))
      (LLVM.xor (LLVM.xor e✝ e✝¹) (const? 33)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test16_thm (e✝ e✝¹ : IntW 8) :
  mul (LLVM.and (LLVM.xor (LLVM.xor e✝¹ (const? 33)) e✝) (LLVM.xor e✝ e✝¹)) (LLVM.xor (LLVM.xor e✝¹ (const? 33)) e✝) ⊑
    mul (LLVM.and (LLVM.xor (LLVM.xor e✝¹ e✝) (const? 33)) (LLVM.xor e✝ e✝¹))
      (LLVM.xor (LLVM.xor e✝¹ e✝) (const? 33)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_xor_to_or_not1_thm (e✝ e✝¹ e✝² : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e✝² e✝¹) (LLVM.or e✝ e✝¹)) (const? (-1)) ⊑
    LLVM.or (LLVM.and e✝² e✝¹) (LLVM.xor (LLVM.or e✝ e✝¹) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_xor_to_or_not2_thm (e✝ e✝¹ e✝² : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e✝² e✝¹) (LLVM.or e✝¹ e✝)) (const? (-1)) ⊑
    LLVM.or (LLVM.and e✝² e✝¹) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_xor_to_or_not3_thm (e✝ e✝¹ e✝² : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e✝² e✝¹) (LLVM.or e✝² e✝)) (const? (-1)) ⊑
    LLVM.or (LLVM.and e✝² e✝¹) (LLVM.xor (LLVM.or e✝² e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_xor_to_or_not4_thm (e✝ e✝¹ e✝² : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e✝² e✝¹) (LLVM.or e✝ e✝²)) (const? (-1)) ⊑
    LLVM.or (LLVM.and e✝² e✝¹) (LLVM.xor (LLVM.or e✝ e✝²) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_notand_to_or_not1_thm (e✝ e✝¹ e✝² : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) (LLVM.or e✝ e✝¹) ⊑
    LLVM.or (LLVM.and e✝² e✝¹) (LLVM.xor (LLVM.or e✝ e✝¹) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_notand_to_or_not2_thm (e✝ e✝¹ e✝² : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) (LLVM.or e✝¹ e✝) ⊑
    LLVM.or (LLVM.and e✝² e✝¹) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_notand_to_or_not3_thm (e✝ e✝¹ e✝² : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) (LLVM.or e✝² e✝) ⊑
    LLVM.or (LLVM.and e✝² e✝¹) (LLVM.xor (LLVM.or e✝² e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_notand_to_or_not4_thm (e✝ e✝¹ e✝² : IntW 3) :
  LLVM.xor (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) (LLVM.or e✝ e✝²) ⊑
    LLVM.or (LLVM.and e✝² e✝¹) (LLVM.xor (LLVM.or e✝ e✝²) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


