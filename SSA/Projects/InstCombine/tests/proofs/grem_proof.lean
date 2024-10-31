
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section grem_proof
theorem test1_thm (e✝ : IntW 32) : LLVM.srem e✝ (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e✝ : IntW 32) : urem e✝ (const? 8) ⊑ LLVM.and e✝ (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e✝ : IntW 1) (e✝¹ : IntW 32) :
  urem e✝¹ (select e✝ (const? 1) (const? 8)) ⊑ LLVM.and e✝¹ (select e✝ (const? 0) (const? 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e✝ : IntW 8) (e✝¹ : IntW 32) :
  urem e✝¹ (shl (const? 32) (zext 32 e✝)) ⊑
    LLVM.and e✝¹ (add (shl (const? 32) (zext 32 e✝) { «nsw» := false, «nuw» := true }) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e✝ : IntW 32) : LLVM.srem (mul e✝ (const? 8)) (const? 4) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm (e✝ : IntW 32) : LLVM.srem (shl e✝ (const? 4)) (const? 8) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm (e✝ : IntW 32) : urem (mul e✝ (const? 64)) (const? 32) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm (e✝ : IntW 8) :
  trunc 32 (urem (sext 64 (mul (zext 32 e✝) (const? 4))) (const? 4)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11_thm (e✝ : IntW 32) : urem (mul (LLVM.and e✝ (const? (-2))) (const? 2)) (const? 4) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_thm (e✝ : IntW 32) : LLVM.srem (LLVM.and e✝ (const? (-4))) (const? 2) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm (e✝ : IntW 32) : LLVM.srem e✝ e✝ ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test14_thm (e✝ : IntW 32) (e✝¹ : IntW 64) :
  urem e✝¹ (zext 64 (shl (const? 1) e✝)) ⊑
    LLVM.and e✝¹
      (add (zext 64 (shl (const? 1) e✝ { «nsw» := false, «nuw» := true })) (const? (-1))
        { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15_thm (e✝ e✝¹ : IntW 32) :
  urem (zext 64 e✝¹) (zext 64 (shl (const? 1) e✝)) ⊑
    zext 64 (LLVM.and e✝¹ (LLVM.xor (shl (const? (-1)) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test16_thm (e✝ e✝¹ : IntW 32) :
  urem e✝¹ (add (LLVM.and (lshr e✝ (const? 11)) (const? 4)) (const? 4)) ⊑
    LLVM.and e✝¹ (LLVM.or (LLVM.and (lshr e✝ (const? 11)) (const? 4)) (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test19_thm (e✝ e✝¹ : IntW 32) :
  urem e✝¹ (add (LLVM.and (shl (const? 1) e✝) (shl (const? 1) e✝¹)) (shl (const? 1) e✝)) ⊑
    LLVM.and e✝¹
      (add
        (add
          (LLVM.and (shl (const? 1) e✝ { «nsw» := false, «nuw» := true })
            (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true }))
          (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }))
        (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test19_commutative0_thm (e✝ e✝¹ : IntW 32) :
  urem e✝¹ (add (LLVM.and (shl (const? 1) e✝¹) (shl (const? 1) e✝)) (shl (const? 1) e✝)) ⊑
    LLVM.and e✝¹
      (add
        (add
          (LLVM.and (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true })
            (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }))
          (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }))
        (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test19_commutative1_thm (e✝ e✝¹ : IntW 32) :
  urem e✝¹ (add (shl (const? 1) e✝) (LLVM.and (shl (const? 1) e✝) (shl (const? 1) e✝¹))) ⊑
    LLVM.and e✝¹
      (add
        (add (shl (const? 1) e✝ { «nsw» := false, «nuw» := true })
          (LLVM.and (shl (const? 1) e✝ { «nsw» := false, «nuw» := true })
            (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true })))
        (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test19_commutative2_thm (e✝ e✝¹ : IntW 32) :
  urem e✝¹ (add (shl (const? 1) e✝) (LLVM.and (shl (const? 1) e✝¹) (shl (const? 1) e✝))) ⊑
    LLVM.and e✝¹
      (add
        (add (shl (const? 1) e✝ { «nsw» := false, «nuw» := true })
          (LLVM.and (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true })
            (shl (const? 1) e✝ { «nsw» := false, «nuw» := true })))
        (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test22_thm (e✝ : IntW 32) :
  LLVM.srem (LLVM.and e✝ (const? 2147483647)) (const? 2147483647) ⊑
    urem (LLVM.and e✝ (const? 2147483647)) (const? 2147483647) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem srem_constant_dividend_select_of_constants_divisor_thm (e✝ : IntW 1) :
  LLVM.srem (const? 42) (select e✝ (const? 12) (const? (-3))) ⊑ select e✝ (const? 6) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem srem_constant_dividend_select_of_constants_divisor_0_arm_thm (e✝ : IntW 1) : LLVM.srem (const? 42) (select e✝ (const? 12) (const? 0)) ⊑ const? 6 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_constant_dividend_select_of_constants_divisor_thm (e✝ : IntW 1) :
  urem (const? 42) (select e✝ (const? 12) (const? (-3))) ⊑ select e✝ (const? 6) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_constant_dividend_select_of_constants_divisor_0_arm_thm (e✝ : IntW 1) : urem (const? 42) (select e✝ (const? 12) (const? 0)) ⊑ const? 6 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


