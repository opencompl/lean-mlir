
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gorhxor_proof
theorem test1_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or e✝¹ (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) ⊑ LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or e✝¹ (LLVM.xor (LLVM.or e✝ e✝¹) (const? (-1))) ⊑ LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or e✝¹ (LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1))) ⊑ LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or e✝¹ (LLVM.xor (LLVM.xor e✝ e✝¹) (const? (-1))) ⊑ LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.xor e✝¹ e✝) (LLVM.xor e✝¹ (const? (-1))) ⊑ LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_commuted_x_y_thm (e✝ e✝¹ : IntW 64) :
  LLVM.or (LLVM.xor e✝¹ e✝) (LLVM.xor e✝ (const? (-1))) ⊑ LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_common_op_commute0_thm (e✝ e✝¹ : IntW 8) : LLVM.or (LLVM.xor e✝¹ e✝) e✝¹ ⊑ LLVM.or e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_common_op_commute2_thm (e✝ e✝¹ : IntW 8) :
  LLVM.or (LLVM.xor e✝¹ (const? 5)) (LLVM.xor (LLVM.xor e✝¹ (const? 5)) e✝) ⊑
    LLVM.or (LLVM.xor e✝¹ (const? 5)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_common_op_commute3_thm (e✝ e✝¹ : IntW 8) :
  LLVM.or (LLVM.xor e✝¹ (const? 5)) (LLVM.xor (mul e✝ e✝) (LLVM.xor e✝¹ (const? 5))) ⊑
    LLVM.or (LLVM.xor e✝¹ (const? 5)) (mul e✝ e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or e✝¹ (LLVM.xor e✝ (LLVM.xor e✝¹ (const? (-1)))) ⊑ LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or e✝¹ (LLVM.xor (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑ LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝ (const? (-1))) e✝¹) ⊑
    LLVM.or (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝ e✝¹) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_commuted_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor e✝¹ (const? (-1))) e✝) (LLVM.xor e✝ e✝¹) ⊑
    LLVM.or (LLVM.xor e✝ e✝¹) (LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.or e✝¹ e✝) (LLVM.xor (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑ LLVM.and e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e✝¹ (const? (-1))) e✝) (LLVM.or e✝¹ e✝) ⊑ LLVM.and e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_commuted_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e✝¹ (const? (-1))) e✝) (LLVM.or e✝ e✝¹) ⊑ LLVM.and e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm (e✝ e✝¹ : IntW 32) : LLVM.xor (LLVM.or e✝¹ e✝) (LLVM.xor e✝¹ e✝) ⊑ LLVM.and e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test14_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1)))) (LLVM.or (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑
    LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test14_commuted_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.xor e✝¹ (const? (-1))) e✝) (LLVM.or (LLVM.xor e✝ (const? (-1))) e✝¹) ⊑
    LLVM.xor e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.and e✝¹ (LLVM.xor e✝ (const? (-1)))) (LLVM.and (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑
    LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15_commuted_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e✝¹ (const? (-1))) e✝) (LLVM.and (LLVM.xor e✝ (const? (-1))) e✝¹) ⊑
    LLVM.xor e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_xor_not_constant_commute0_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor e✝¹ e✝) (const? 1)) (LLVM.and e✝ (const? (-2))) ⊑
    LLVM.xor (LLVM.and e✝¹ (const? 1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and_xor_not_constant_commute1_thm (e✝ e✝¹ : IntW 9) :
  LLVM.or (LLVM.and (LLVM.xor e✝¹ e✝) (const? 42)) (LLVM.and e✝¹ (const? (-43))) ⊑
    LLVM.xor (LLVM.and e✝ (const? 42)) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_xor_thm (e✝ : IntW 8) :
  LLVM.xor (LLVM.or (LLVM.xor e✝ (const? (-1))) (const? 7)) (const? 12) ⊑
    LLVM.xor (LLVM.and e✝ (const? (-8))) (const? (-13)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or_thm (e✝ : IntW 8) :
  LLVM.or (LLVM.xor e✝ (const? 32)) (const? 7) ⊑ LLVM.xor (LLVM.and e✝ (const? (-8))) (const? 39) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or2_thm (e✝ : IntW 8) :
  LLVM.or (LLVM.xor e✝ (const? 33)) (const? 7) ⊑ LLVM.xor (LLVM.and e✝ (const? (-8))) (const? 39) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_or_xor_thm (e✝ : IntW 8) :
  LLVM.xor (LLVM.or (LLVM.xor e✝ (const? 33)) (const? 7)) (const? 12) ⊑
    LLVM.xor (LLVM.and e✝ (const? (-8))) (const? 43) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_or_thm (e✝ : IntW 8) :
  LLVM.or (LLVM.xor (LLVM.or e✝ (const? 33)) (const? 12)) (const? 7) ⊑
    LLVM.xor (LLVM.and e✝ (const? (-40))) (const? 47) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test17_thm (e✝ e✝¹ : IntW 8) :
  mul (LLVM.or (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝ (const? 33)) e✝¹)) (LLVM.xor (LLVM.xor e✝ (const? 33)) e✝¹) ⊑
    mul (LLVM.or (LLVM.xor e✝¹ e✝) (LLVM.xor (LLVM.xor e✝ e✝¹) (const? 33)))
      (LLVM.xor (LLVM.xor e✝ e✝¹) (const? 33)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test18_thm (e✝ e✝¹ : IntW 8) :
  mul (LLVM.or (LLVM.xor (LLVM.xor e✝¹ (const? 33)) e✝) (LLVM.xor e✝ e✝¹)) (LLVM.xor (LLVM.xor e✝¹ (const? 33)) e✝) ⊑
    mul (LLVM.or (LLVM.xor (LLVM.xor e✝¹ e✝) (const? 33)) (LLVM.xor e✝ e✝¹))
      (LLVM.xor (LLVM.xor e✝¹ e✝) (const? 33)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test19_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.or e✝¹ e✝) (LLVM.or (LLVM.xor e✝¹ (const? (-1))) (LLVM.xor e✝ (const? (-1)))) ⊑
    LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test20_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.or e✝¹ e✝) (LLVM.or (LLVM.xor e✝ (const? (-1))) (LLVM.xor e✝¹ (const? (-1)))) ⊑
    LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test21_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.xor e✝¹ (const? (-1))) (LLVM.xor e✝ (const? (-1)))) (LLVM.or e✝¹ e✝) ⊑
    LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test22_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.xor e✝¹ (const? (-1))) (LLVM.xor e✝ (const? (-1)))) (LLVM.or e✝ e✝¹) ⊑
    LLVM.xor (LLVM.xor e✝ e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test23_thm (e✝ : IntW 8) :
  LLVM.xor (LLVM.or (LLVM.xor (LLVM.or e✝ (const? (-2))) (const? 13)) (const? 1)) (const? 12) ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR45977_f1_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) (LLVM.and (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑
    LLVM.xor e✝¹ (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR45977_f2_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (LLVM.or e✝¹ e✝) (LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1)))) ⊑ LLVM.xor e✝¹ (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_common_op_commute0_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (LLVM.or e✝² e✝¹) (LLVM.xor e✝² e✝) ⊑ LLVM.or (LLVM.or e✝² e✝¹) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_common_op_commute5_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (LLVM.xor e✝² e✝¹) (LLVM.or e✝ e✝²) ⊑ LLVM.or (LLVM.or e✝ e✝²) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_common_op_commute6_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (LLVM.xor e✝² e✝¹) (LLVM.or e✝¹ e✝) ⊑ LLVM.or (LLVM.or e✝¹ e✝) e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_common_op_commute7_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (LLVM.xor e✝² e✝¹) (LLVM.or e✝ e✝¹) ⊑ LLVM.or (LLVM.or e✝ e✝¹) e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_xor_common_op_commute0_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.or (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) (LLVM.xor e✝² e✝) ⊑
    LLVM.or e✝¹ (LLVM.xor (LLVM.and e✝² e✝) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_xor_common_op_commute2_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (LLVM.xor e✝² e✝¹) (LLVM.or (sub (const? 0) e✝) (LLVM.xor e✝² (const? (-1)))) ⊑
    LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) (sub (const? 0) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_xor_common_op_commute3_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (LLVM.or (sub (const? 0) e✝²) (LLVM.xor e✝¹ (const? (-1)))) (LLVM.xor e✝¹ e✝) ⊑
    LLVM.or (LLVM.xor (LLVM.and e✝¹ e✝) (const? (-1))) (sub (const? 0) e✝²) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_xor_common_op_commute5_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (LLVM.xor e✝² e✝¹) (LLVM.or (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑
    LLVM.or e✝ (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_xor_common_op_commute6_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (LLVM.xor e✝² e✝¹) (LLVM.or (sub (const? 0) e✝) (LLVM.xor e✝¹ (const? (-1)))) ⊑
    LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) (sub (const? 0) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_not_xor_common_op_commute7_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (LLVM.or (sub (const? 0) e✝²) (LLVM.xor e✝¹ (const? (-1)))) (LLVM.xor e✝ e✝¹) ⊑
    LLVM.or (LLVM.xor (LLVM.and e✝ e✝¹) (const? (-1))) (sub (const? 0) e✝²) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_nand_xor_common_op_commute0_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.or (LLVM.xor (LLVM.and e✝² e✝¹) (const? (-1))) (LLVM.xor e✝² e✝) ⊑
    LLVM.xor (LLVM.and (LLVM.and e✝² e✝¹) e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR75692_1_thm (e✝ : IntW 32) : LLVM.or (LLVM.xor e✝ (const? 4)) (LLVM.xor e✝ (const? (-5))) ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_not_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.xor e✝¹ (LLVM.xor e✝ (const? (-1)))) e✝ ⊑ LLVM.or e✝ (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_and_commuted1_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (mul e✝¹ e✝¹) (LLVM.xor (LLVM.xor (mul e✝¹ e✝¹) (const? (-1))) e✝) ⊑
    LLVM.or (mul e✝¹ e✝¹) (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_and_commuted2_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝¹ e✝¹) (LLVM.xor (mul e✝ e✝) (const? (-1)))) (mul e✝ e✝) ⊑
    LLVM.or (mul e✝ e✝) (LLVM.xor (mul e✝¹ e✝¹) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_0000_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42)))
      (LLVM.xor (LLVM.xor (mul e✝¹ (const? 42)) (mul e✝ (const? 42))) (mul e✝² (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_0001_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42)))
      (LLVM.xor (LLVM.xor (mul e✝² (const? 42)) (mul e✝ (const? 42))) (mul e✝¹ (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_0010_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42)))
      (LLVM.xor (LLVM.xor (mul e✝ (const? 42)) (mul e✝¹ (const? 42))) (mul e✝² (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_0011_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42)))
      (LLVM.xor (LLVM.xor (mul e✝ (const? 42)) (mul e✝² (const? 42))) (mul e✝¹ (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_0100_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42)))
      (LLVM.xor (mul e✝² (const? 42)) (LLVM.xor (mul e✝¹ (const? 42)) (mul e✝ (const? 42)))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_0101_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42)))
      (LLVM.xor (mul e✝¹ (const? 42)) (LLVM.xor (mul e✝² (const? 42)) (mul e✝ (const? 42)))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_0110_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42)))
      (LLVM.xor (mul e✝² (const? 42)) (LLVM.xor (mul e✝ (const? 42)) (mul e✝¹ (const? 42)))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_0111_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42)))
      (LLVM.xor (mul e✝¹ (const? 42)) (LLVM.xor (mul e✝ (const? 42)) (mul e✝² (const? 42)))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_1000_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)))
      (LLVM.xor (mul e✝ (const? 42)) (mul e✝² (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝ (const? 42)) (mul e✝² (const? 42))) (mul e✝¹ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_1001_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)))
      (LLVM.xor (mul e✝² (const? 42)) (mul e✝ (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝ (const? 42))) (mul e✝¹ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_1010_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)))
      (LLVM.xor (mul e✝ (const? 42)) (mul e✝¹ (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝ (const? 42)) (mul e✝¹ (const? 42))) (mul e✝² (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_1011_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)))
      (LLVM.xor (mul e✝¹ (const? 42)) (mul e✝ (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝¹ (const? 42)) (mul e✝ (const? 42))) (mul e✝² (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_1100_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (LLVM.xor (mul e✝¹ (const? 42)) (mul e✝ (const? 42))))
      (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝¹ (const? 42))) (mul e✝ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_1101_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (LLVM.xor (mul e✝¹ (const? 42)) (mul e✝ (const? 42))))
      (LLVM.xor (mul e✝¹ (const? 42)) (mul e✝² (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝¹ (const? 42)) (mul e✝² (const? 42))) (mul e✝ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_1110_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (LLVM.xor (mul e✝¹ (const? 42)) (mul e✝ (const? 42))))
      (LLVM.xor (mul e✝² (const? 42)) (mul e✝ (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝² (const? 42)) (mul e✝ (const? 42))) (mul e✝¹ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_xor_tree_1111_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.xor (mul e✝² (const? 42)) (LLVM.xor (mul e✝¹ (const? 42)) (mul e✝ (const? 42))))
      (LLVM.xor (mul e✝ (const? 42)) (mul e✝² (const? 42))) ⊑
    LLVM.or (LLVM.xor (mul e✝ (const? 42)) (mul e✝² (const? 42))) (mul e✝¹ (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


