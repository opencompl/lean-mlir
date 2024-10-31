
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthshift_proof
theorem test6_thm (e✝ : IntW 55) : mul (shl e✝ (const? 1)) (const? 3) ⊑ mul e✝ (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6a_thm (e✝ : IntW 55) : shl (mul e✝ (const? 3)) (const? 1) ⊑ mul e✝ (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e✝ : IntW 8) : ashr (const? (-1)) (zext 29 e✝) ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm (e✝ : IntW 7) : shl (shl e✝ (const? 4)) (const? 3) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm (e✝ : IntW 17) : lshr (shl e✝ (const? 16)) (const? 16) ⊑ LLVM.and e✝ (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm (e✝ : IntW 19) : shl (lshr e✝ (const? 18)) (const? 18) ⊑ LLVM.and e✝ (const? (-262144)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem multiuse_lshr_lshr_thm (e✝ : IntW 9) :
  mul (lshr e✝ (const? 2)) (lshr (lshr e✝ (const? 2)) (const? 3)) ⊑
    mul (lshr e✝ (const? 2)) (lshr e✝ (const? 5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem multiuse_shl_shl_thm (e✝ : IntW 42) :
  mul (shl e✝ (const? 8)) (shl (shl e✝ (const? 8)) (const? 9)) ⊑ mul (shl e✝ (const? 8)) (shl e✝ (const? 17)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11_thm (e✝ : IntW 23) :
  shl (lshr (mul e✝ (const? 3)) (const? 11)) (const? 12) ⊑ LLVM.and (mul e✝ (const? 6)) (const? (-4096)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_thm (e✝ : IntW 47) : shl (ashr e✝ (const? 8)) (const? 8) ⊑ LLVM.and e✝ (const? (-256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm (e✝ : IntW 18) :
  shl (ashr (mul e✝ (const? 3)) (const? 8)) (const? 9) ⊑ LLVM.and (mul e✝ (const? 6)) (const? (-512)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test14_thm (e✝ : IntW 35) :
  shl (LLVM.or (lshr e✝ (const? 4)) (const? 1234)) (const? 4) ⊑
    LLVM.or (LLVM.and e✝ (const? (-19760))) (const? 19744) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test14a_thm (e✝ : IntW 79) :
  lshr (LLVM.and (shl e✝ (const? 4)) (const? 1234)) (const? 4) ⊑ LLVM.and e✝ (const? 77) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15_thm (e✝ : IntW 1) :
  shl (select e✝ (const? 3) (const? 1)) (const? 2) ⊑ select e✝ (const? 12) (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15a_thm (e✝ : IntW 1) :
  shl (const? 64) (zext 53 (select e✝ (const? 3) (const? 1))) ⊑ select e✝ (const? 512) (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test23_thm (e✝ : IntW 44) : trunc 11 (ashr (shl e✝ (const? 33)) (const? 33)) ⊑ trunc 11 e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_eq_amt_multi_use_thm (e✝ : IntW 44) :
  add (shl e✝ (const? 33)) (lshr (shl e✝ (const? 33)) (const? 33)) ⊑
    LLVM.or (shl e✝ (const? 33)) (LLVM.and e✝ (const? 2047)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_shl_eq_amt_multi_use_thm (e✝ : IntW 43) :
  mul (lshr e✝ (const? 23)) (shl (lshr e✝ (const? 23)) (const? 23)) ⊑
    mul (lshr e✝ (const? 23)) (LLVM.and e✝ (const? (-8388608))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test25_thm (e✝ e✝¹ : IntW 37) :
  shl (add (lshr e✝¹ (const? 17)) (lshr e✝ (const? 17))) (const? 17) ⊑
    LLVM.and (add e✝ (LLVM.and e✝¹ (const? (-131072)))) (const? (-131072)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


