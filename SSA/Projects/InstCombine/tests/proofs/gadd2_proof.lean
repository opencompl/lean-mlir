
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gadd2_proof
theorem test1_thm (e✝ : IntW 64) (e✝¹ : IntW 32) :
  LLVM.and (add (shl (zext 64 e✝¹) (const? 32)) e✝) (const? 123) ⊑ LLVM.and e✝ (const? 123) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ : IntW 32) :
  add (LLVM.and e✝ (const? 7)) (LLVM.and e✝ (const? 32)) ⊑ LLVM.and e✝ (const? 39) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e✝ : IntW 32) :
  add (LLVM.and e✝ (const? 128)) (lshr e✝ (const? 30)) ⊑
    LLVM.or (LLVM.and e✝ (const? 128)) (lshr e✝ (const? 30)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e✝ : IntW 32) :
  add e✝ e✝ { «nsw» := false, «nuw» := true } ⊑ shl e✝ (const? 1) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm (e✝ : IntW 16) : add (mul e✝ (const? 2)) (mul e✝ (const? 32767)) ⊑ mul e✝ (const? (-32767)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm (e✝ e✝¹ : IntW 32) :
  add (add e✝¹ (const? 1)) (LLVM.xor (LLVM.or (ashr e✝ (const? 3)) (const? (-1431655766))) (const? 1431655765)) ⊑
    sub e✝¹ (LLVM.and (ashr e✝ (const? 3)) (const? 1431655765)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11_thm (e✝ e✝¹ : IntW 32) :
  add (add e✝¹ (const? 1)) (LLVM.xor (LLVM.or e✝ (const? (-1431655766))) (const? 1431655765)) ⊑
    sub e✝¹ (LLVM.and e✝ (const? 1431655765)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_thm (e✝ e✝¹ : IntW 32) :
  add (add e✝¹ (const? 1) { «nsw» := true, «nuw» := false })
      (LLVM.xor (LLVM.or e✝ (const? (-1431655766))) (const? 1431655765)) { «nsw» := true, «nuw» := false } ⊑
    sub e✝¹ (LLVM.and e✝ (const? 1431655765)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm (e✝ e✝¹ : IntW 32) :
  add (add e✝¹ (const? 1)) (LLVM.xor (LLVM.or e✝ (const? (-1431655767))) (const? 1431655766)) ⊑
    sub e✝¹ (LLVM.and e✝ (const? 1431655766)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test14_thm (e✝ e✝¹ : IntW 32) :
  add (add e✝¹ (const? 1) { «nsw» := true, «nuw» := false })
      (LLVM.xor (LLVM.or e✝ (const? (-1431655767))) (const? 1431655766)) { «nsw» := true, «nuw» := false } ⊑
    sub e✝¹ (LLVM.and e✝ (const? 1431655766)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15_thm (e✝ e✝¹ : IntW 32) :
  add (add e✝¹ (const? 1)) (LLVM.xor (LLVM.and e✝ (const? (-1431655767))) (const? (-1431655767))) ⊑
    sub e✝¹ (LLVM.or e✝ (const? 1431655766)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test16_thm (e✝ e✝¹ : IntW 32) :
  add (add e✝¹ (const? 1) { «nsw» := true, «nuw» := false })
      (LLVM.xor (LLVM.and e✝ (const? (-1431655767))) (const? (-1431655767))) { «nsw» := true, «nuw» := false } ⊑
    sub e✝¹ (LLVM.or e✝ (const? 1431655766)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test17_thm (e✝ e✝¹ : IntW 32) :
  add (LLVM.xor (LLVM.and e✝¹ (const? (-1431655766))) (const? (-1431655765))) e✝ { «nsw» := true, «nuw» := false } ⊑
    sub e✝ (LLVM.or e✝¹ (const? 1431655765)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test18_thm (e✝ e✝¹ : IntW 32) :
  add (add e✝¹ (const? 1) { «nsw» := true, «nuw» := false })
      (LLVM.xor (LLVM.and e✝ (const? (-1431655766))) (const? (-1431655766))) { «nsw» := true, «nuw» := false } ⊑
    sub e✝¹ (LLVM.or e✝ (const? 1431655765)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nsw_mul_nsw_thm (e✝ : IntW 16) :
  add (add e✝ e✝ { «nsw» := true, «nuw» := false }) e✝ { «nsw» := true, «nuw» := false } ⊑
    mul e✝ (const? 3) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_add_to_mul_1_thm (e✝ : IntW 16) :
  add e✝ (mul e✝ (const? 8) { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    mul e✝ (const? 9) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_add_to_mul_2_thm (e✝ : IntW 16) :
  add (mul e✝ (const? 8) { «nsw» := true, «nuw» := false }) e✝ { «nsw» := true, «nuw» := false } ⊑
    mul e✝ (const? 9) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_add_to_mul_3_thm (e✝ : IntW 16) :
  add (mul e✝ (const? 2)) (mul e✝ (const? 3)) { «nsw» := true, «nuw» := false } ⊑ mul e✝ (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_add_to_mul_4_thm (e✝ : IntW 16) :
  add (mul e✝ (const? 2) { «nsw» := true, «nuw» := false }) (mul e✝ (const? 7) { «nsw» := true, «nuw» := false })
      { «nsw» := true, «nuw» := false } ⊑
    mul e✝ (const? 9) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_add_to_mul_5_thm (e✝ : IntW 16) :
  add (mul e✝ (const? 3) { «nsw» := true, «nuw» := false }) (mul e✝ (const? 7) { «nsw» := true, «nuw» := false })
      { «nsw» := true, «nuw» := false } ⊑
    mul e✝ (const? 10) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_add_to_mul_6_thm (e✝ e✝¹ : IntW 32) :
  add (mul e✝¹ e✝ { «nsw» := true, «nuw» := false })
      (mul (mul e✝¹ e✝ { «nsw» := true, «nuw» := false }) (const? 5) { «nsw» := true, «nuw» := false })
      { «nsw» := true, «nuw» := false } ⊑
    mul (mul e✝¹ e✝ { «nsw» := true, «nuw» := false }) (const? 6) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_add_to_mul_7_thm (e✝ : IntW 16) :
  add e✝ (mul e✝ (const? 32767) { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    shl e✝ (const? 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_add_to_mul_8_thm (e✝ : IntW 16) :
  add (mul e✝ (const? 16383) { «nsw» := true, «nuw» := false })
      (mul e✝ (const? 16384) { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    mul e✝ (const? 32767) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_add_to_mul_9_thm (e✝ : IntW 16) :
  add (mul e✝ (const? 16384) { «nsw» := true, «nuw» := false })
      (mul e✝ (const? 16384) { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    shl e✝ (const? 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_or_and_thm (e✝ e✝¹ : IntW 32) : add (LLVM.or e✝¹ e✝) (LLVM.and e✝¹ e✝) ⊑ add e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_or_and_commutative_thm (e✝ e✝¹ : IntW 32) : add (LLVM.or e✝¹ e✝) (LLVM.and e✝ e✝¹) ⊑ add e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_and_or_thm (e✝ e✝¹ : IntW 32) : add (LLVM.and e✝¹ e✝) (LLVM.or e✝¹ e✝) ⊑ add e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_and_or_commutative_thm (e✝ e✝¹ : IntW 32) : add (LLVM.and e✝¹ e✝) (LLVM.or e✝ e✝¹) ⊑ add e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nsw_or_and_thm (e✝ e✝¹ : IntW 32) :
  add (LLVM.or e✝¹ e✝) (LLVM.and e✝¹ e✝) { «nsw» := true, «nuw» := false } ⊑
    add e✝¹ e✝ { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nuw_or_and_thm (e✝ e✝¹ : IntW 32) :
  add (LLVM.or e✝¹ e✝) (LLVM.and e✝¹ e✝) { «nsw» := false, «nuw» := true } ⊑
    add e✝¹ e✝ { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nuw_nsw_or_and_thm (e✝ e✝¹ : IntW 32) :
  add (LLVM.or e✝¹ e✝) (LLVM.and e✝¹ e✝) { «nsw» := true, «nuw» := true } ⊑
    add e✝¹ e✝ { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_of_mul_thm (e✝ e✝¹ e✝² : IntW 8) :
  add (mul e✝² e✝¹ { «nsw» := true, «nuw» := false }) (mul e✝² e✝ { «nsw» := true, «nuw» := false })
      { «nsw» := true, «nuw» := false } ⊑
    mul e✝² (add e✝¹ e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_of_selects_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  add (select e✝¹ (const? 0) (const? (-2))) (select e✝¹ e✝ (const? 2)) ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_undemanded_low_bits_thm (e✝ : IntW 32) :
  lshr (add (LLVM.or e✝ (const? 15)) (const? 1616)) (const? 4) ⊑ lshr (add e✝ (const? 1616)) (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_undemanded_low_bits_thm (e✝ : IntW 32) :
  lshr (sub (LLVM.or e✝ (const? 15)) (const? 1616)) (const? 4) ⊑ lshr (add e✝ (const? (-1616))) (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


