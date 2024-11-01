
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gand_proof
theorem test_with_1_thm (e : IntW 32) :
  LLVM.and (shl (const? 1) e) (const? 1) ⊑ zext 32 (icmp IntPredicate.eq e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_with_3_thm (e : IntW 32) :
  LLVM.and (shl (const? 3) e) (const? 1) ⊑ zext 32 (icmp IntPredicate.eq e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_with_5_thm (e : IntW 32) :
  LLVM.and (shl (const? 5) e) (const? 1) ⊑ zext 32 (icmp IntPredicate.eq e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_with_neg_5_thm (e : IntW 32) :
  LLVM.and (shl (const? (-5)) e) (const? 1) ⊑ zext 32 (icmp IntPredicate.eq e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_with_even_thm (e : IntW 32) : LLVM.and (shl (const? 4) e) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_with_neg_even_thm (e : IntW 32) : LLVM.and (shl (const? (-4)) e) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test1_thm (e : IntW 32) : LLVM.and e (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e : IntW 32) : LLVM.and e (const? (-1)) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e : IntW 1) : LLVM.and e (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_logical_thm (e : IntW 1) : select e (const? 0) (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e : IntW 1) : LLVM.and e (const? 1) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_logical_thm (e : IntW 1) : select e (const? 1) (const? 0) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e : IntW 32) : LLVM.and e e ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm (e : IntW 1) : LLVM.and e e ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_logical_thm (e : IntW 1) : select e e (const? 0) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e : IntW 32) : LLVM.and e (LLVM.xor e (const? (-1))) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm (e : IntW 8) : LLVM.and (LLVM.and e (const? 3)) (const? 4) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.and e (const? (-2147483648))) (const? 0) ⊑ icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9a_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.and e (const? (-2147483648))) (const? 0) ⊑ icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm (e : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.and e (const? 12)) (const? 15)) (const? 1) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ule e_1 e) ⊑ icmp IntPredicate.ult e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ule e_1 e) (const? 0) ⊑ icmp IntPredicate.ult e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ugt e_1 e) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ugt e_1 e) (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test14_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and e (const? (-128))) (const? 0) ⊑ icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15_thm (e : IntW 8) : LLVM.and (lshr e (const? 7)) (const? 2) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test16_thm (e : IntW 8) : LLVM.and (shl e (const? 2)) (const? 3) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test18_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.and e (const? (-128))) (const? 0) ⊑ icmp IntPredicate.ugt e (const? 127) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test18a_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and e (const? (-2))) (const? 0) ⊑ icmp IntPredicate.ult e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test19_thm (e : IntW 32) : LLVM.and (shl e (const? 3)) (const? (-2)) ⊑ shl e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test20_thm (e : IntW 8) : LLVM.and (lshr e (const? 7)) (const? 1) ⊑ lshr e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test23_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt e (const? 1)) (icmp IntPredicate.sle e (const? 2)) ⊑
    icmp IntPredicate.eq e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test23_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt e (const? 1)) (icmp IntPredicate.sle e (const? 2)) (const? 0) ⊑
    icmp IntPredicate.eq e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test24_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt e (const? 1)) (icmp IntPredicate.ne e (const? 2)) ⊑
    icmp IntPredicate.sgt e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test24_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt e (const? 1)) (icmp IntPredicate.ne e (const? 2)) (const? 0) ⊑
    icmp IntPredicate.sgt e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test25_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sge e (const? 50)) (icmp IntPredicate.slt e (const? 100)) ⊑
    icmp IntPredicate.ult (add e (const? (-50))) (const? 50) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test25_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sge e (const? 50)) (icmp IntPredicate.slt e (const? 100)) (const? 0) ⊑
    icmp IntPredicate.ult (add e (const? (-50))) (const? 50) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test27_thm (e : IntW 8) :
  add (LLVM.and (sub (LLVM.and e (const? 4)) (const? 16)) (const? (-16))) (const? 16) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_lowmask_thm (e : IntW 32) : LLVM.and (ashr e (const? 24)) (const? 255) ⊑ lshr e (const? 24) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test29_thm (e : IntW 8) : LLVM.and (zext 32 e) (const? 255) ⊑ zext 32 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test30_thm (e : IntW 1) : LLVM.and (zext 32 e) (const? 1) ⊑ zext 32 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test31_thm (e : IntW 1) :
  LLVM.and (shl (zext 32 e) (const? 4)) (const? 16) ⊑ select e (const? 16) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_demanded_thm (e : IntW 16) (e_1 : IntW 32) :
  LLVM.and (LLVM.or e_1 (const? 255)) (zext 32 (lshr e (const? 8))) ⊑ zext 32 (lshr e (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test32_thm (e : IntW 32) : LLVM.and (lshr (LLVM.and e (const? 16)) (const? 2)) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test33_thm (e : IntW 32) :
  LLVM.or (LLVM.and e (const? (-2))) (LLVM.xor (LLVM.and e (const? 1)) (const? 1)) ⊑ LLVM.xor e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test33b_thm (e : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.and e (const? 1)) (const? 1)) (LLVM.and e (const? (-2))) ⊑ LLVM.xor e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test34_thm (e e_1 : IntW 32) : LLVM.and (LLVM.or e_1 e) e_1 ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test35_thm (e : IntW 32) :
  LLVM.and (sub (const? 0) (zext 64 e)) (const? 240) ⊑ zext 64 (LLVM.and (sub (const? 0) e) (const? 240)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test36_thm (e : IntW 32) :
  LLVM.and (add (zext 64 e) (const? 7)) (const? 240) ⊑ zext 64 (LLVM.and (add e (const? 7)) (const? 240)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test37_thm (e : IntW 32) :
  LLVM.and (mul (zext 64 e) (const? 7)) (const? 240) ⊑ zext 64 (LLVM.and (mul e (const? 7)) (const? 240)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test38_thm (e : IntW 32) :
  LLVM.and (LLVM.xor (zext 64 e) (const? 7)) (const? 240) ⊑ zext 64 (LLVM.and e (const? 240)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test39_thm (e : IntW 32) :
  LLVM.and (LLVM.or (zext 64 e) (const? 7)) (const? 240) ⊑ zext 64 (LLVM.and e (const? 240)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_add_zext_thm (e : IntW 32) (e_1 : IntW 8) :
  LLVM.and (add (zext 32 e_1) e) (const? 255) ⊑ zext 32 (add e_1 (trunc 8 e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_add_zext_commute_thm (e : IntW 16) (e_1 : IntW 32) :
  LLVM.and (add (mul e_1 e_1) (zext 32 e)) (const? 65535) ⊑ zext 32 (add e (trunc 16 (mul e_1 e_1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_add_zext_wrong_mask_thm (e : IntW 32) (e_1 : IntW 8) :
  LLVM.and (add (zext 32 e_1) e) (const? 511) ⊑ LLVM.and (add e (zext 32 e_1)) (const? 511) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_sub_zext_commute_thm (e : IntW 5) (e_1 : IntW 17) :
  LLVM.and (sub e_1 (zext 17 e)) (const? 31) ⊑ zext 17 (sub (trunc 5 e_1) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_mul_zext_thm (e : IntW 32) (e_1 : IntW 8) :
  LLVM.and (mul (zext 32 e_1) e) (const? 255) ⊑ zext 32 (mul e_1 (trunc 8 e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_xor_zext_commute_thm (e : IntW 8) (e_1 : IntW 32) :
  LLVM.and (LLVM.xor (mul e_1 e_1) (zext 32 e)) (const? 255) ⊑ zext 32 (LLVM.xor e (trunc 8 (mul e_1 e_1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_or_zext_commute_thm (e : IntW 16) (e_1 : IntW 24) :
  LLVM.and (LLVM.or e_1 (zext 24 e)) (const? 65535) ⊑ zext 24 (LLVM.or e (trunc 16 e_1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test40_thm (e : IntW 1) :
  LLVM.and (select e (const? 1000) (const? 10)) (const? 123) ⊑ select e (const? 104) (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test42_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e_2 (const? (-1))) (mul e_1 e)) (LLVM.or e_2 (mul e_1 e)) ⊑
    LLVM.and (mul e_1 e) e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test43_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or e_2 (mul e_1 e)) (LLVM.xor (LLVM.xor e_2 (const? (-1))) (mul e_1 e)) ⊑
    LLVM.and (mul e_1 e) e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test44_thm (e e_1 : IntW 32) : LLVM.and (LLVM.or (LLVM.xor e_1 (const? (-1))) e) e_1 ⊑ LLVM.and e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test45_thm (e e_1 : IntW 32) : LLVM.and (LLVM.or e_1 (LLVM.xor e (const? (-1)))) e ⊑ LLVM.and e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test46_thm (e e_1 : IntW 32) : LLVM.and e_1 (LLVM.or (LLVM.xor e_1 (const? (-1))) e) ⊑ LLVM.and e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test47_thm (e e_1 : IntW 32) : LLVM.and e_1 (LLVM.or e (LLVM.xor e_1 (const? (-1)))) ⊑ LLVM.and e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_orn_cmp_1_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt e_2 e_1)
      (LLVM.or (icmp IntPredicate.ugt e (const? 42)) (icmp IntPredicate.sle e_2 e_1)) ⊑
    LLVM.and (icmp IntPredicate.sgt e_2 e_1) (icmp IntPredicate.ugt e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_orn_cmp_1_logical_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.sgt e_2 e_1)
      (select (icmp IntPredicate.ugt e (const? 42)) (const? 1) (icmp IntPredicate.sle e_2 e_1)) (const? 0) ⊑
    select (icmp IntPredicate.sgt e_2 e_1) (icmp IntPredicate.ugt e (const? 42)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_orn_cmp_3_thm (e e_1 e_2 : IntW 72) :
  LLVM.and (icmp IntPredicate.ugt e_2 e_1)
      (LLVM.or (icmp IntPredicate.ule e_2 e_1) (icmp IntPredicate.ugt e (const? 42))) ⊑
    LLVM.and (icmp IntPredicate.ugt e_2 e_1) (icmp IntPredicate.ugt e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_orn_cmp_3_logical_thm (e e_1 e_2 : IntW 72) :
  select (icmp IntPredicate.ugt e_2 e_1)
      (select (icmp IntPredicate.ule e_2 e_1) (const? 1) (icmp IntPredicate.ugt e (const? 42))) (const? 0) ⊑
    select (icmp IntPredicate.ugt e_2 e_1) (icmp IntPredicate.ugt e (const? 42)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem andn_or_cmp_1_thm (e e_1 e_2 : IntW 37) :
  LLVM.and (icmp IntPredicate.sle e_2 e_1)
      (LLVM.or (icmp IntPredicate.ugt e (const? 42)) (icmp IntPredicate.sgt e_2 e_1)) ⊑
    LLVM.and (icmp IntPredicate.sle e_2 e_1) (icmp IntPredicate.ugt e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem andn_or_cmp_1_logical_thm (e e_1 e_2 : IntW 37) :
  select (icmp IntPredicate.sle e_2 e_1)
      (select (icmp IntPredicate.ugt e (const? 42)) (const? 1) (icmp IntPredicate.sgt e_2 e_1)) (const? 0) ⊑
    select (icmp IntPredicate.sle e_2 e_1) (icmp IntPredicate.ugt e (const? 42)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem andn_or_cmp_2_thm (e e_1 e_2 : IntW 16) :
  LLVM.and (LLVM.or (icmp IntPredicate.ugt e_2 (const? 42)) (icmp IntPredicate.sge e_1 e))
      (icmp IntPredicate.slt e_1 e) ⊑
    LLVM.and (icmp IntPredicate.ugt e_2 (const? 42)) (icmp IntPredicate.slt e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem andn_or_cmp_2_logical_thm (e e_1 e_2 : IntW 16) :
  select (select (icmp IntPredicate.ugt e_2 (const? 42)) (const? 1) (icmp IntPredicate.sge e_1 e))
      (icmp IntPredicate.slt e_1 e) (const? 0) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 42)) (icmp IntPredicate.slt e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem andn_or_cmp_4_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (icmp IntPredicate.eq e_2 e_1) (icmp IntPredicate.ugt e (const? 42)))
      (icmp IntPredicate.ne e_2 e_1) ⊑
    LLVM.and (icmp IntPredicate.ugt e (const? 42)) (icmp IntPredicate.ne e_2 e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem andn_or_cmp_4_logical_thm (e e_1 e_2 : IntW 32) :
  select (select (icmp IntPredicate.eq e_2 e_1) (const? 1) (icmp IntPredicate.ugt e (const? 42)))
      (icmp IntPredicate.ne e_2 e_1) (const? 0) ⊑
    select (icmp IntPredicate.ne e_2 e_1) (icmp IntPredicate.ugt e (const? 42)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowbitmask_casted_shift_thm (e : IntW 8) :
  LLVM.and (sext 32 (ashr e (const? 1))) (const? 2147483647) ⊑ lshr (sext 32 e) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_add_2_thm (e : IntW 8) : LLVM.and (add e (const? (-64))) (const? 63) ⊑ LLVM.and e (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem flip_masked_bit_thm (e : IntW 8) :
  LLVM.and (add e (const? 16)) (const? 16) ⊑ LLVM.xor (LLVM.and e (const? 16)) (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_bitwidth_mask_thm (e e_1 : IntW 8) :
  LLVM.and (ashr e_1 (const? 7)) e ⊑ select (icmp IntPredicate.slt e_1 (const? 0)) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem signbit_splat_mask_thm (e : IntW 16) (e_1 : IntW 8) :
  LLVM.and (sext 16 (ashr e_1 (const? 7))) e ⊑ select (icmp IntPredicate.slt e_1 (const? 0)) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_signbit_splat_mask1_thm (e : IntW 16) (e_1 : IntW 8) :
  LLVM.and (zext 16 (ashr e_1 (const? 7))) e ⊑ LLVM.and e (zext 16 (ashr e_1 (const? 7))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_signbit_splat_mask2_thm (e : IntW 16) (e_1 : IntW 8) :
  LLVM.and (sext 16 (ashr e_1 (const? 6))) e ⊑ LLVM.and e (sext 16 (ashr e_1 (const? 6))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_ashr_bitwidth_mask_thm (e e_1 : IntW 8) :
  LLVM.and (LLVM.xor (ashr e_1 (const? 7)) (const? (-1))) e ⊑
    select (icmp IntPredicate.slt e_1 (const? 0)) (const? 0) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_ashr_not_bitwidth_mask_thm (e e_1 : IntW 8) :
  LLVM.and (LLVM.xor (ashr e_1 (const? 6)) (const? (-1))) e ⊑
    LLVM.and e (LLVM.xor (ashr e_1 (const? 6)) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_lshr_bitwidth_mask_thm (e e_1 : IntW 8) :
  LLVM.and (LLVM.xor (lshr e_1 (const? 7)) (const? (-1))) e ⊑
    LLVM.and e (LLVM.xor (lshr e_1 (const? 7)) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem invert_signbit_splat_mask_thm (e : IntW 16) (e_1 : IntW 8) :
  LLVM.and (sext 16 (LLVM.xor (ashr e_1 (const? 7)) (const? (-1)))) e ⊑
    select (icmp IntPredicate.sgt e_1 (const? (-1))) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_invert_signbit_splat_mask1_thm (e : IntW 16) (e_1 : IntW 8) :
  LLVM.and (zext 16 (LLVM.xor (ashr e_1 (const? 7)) (const? (-1)))) e ⊑
    LLVM.and e (zext 16 (sext 8 (icmp IntPredicate.sgt e_1 (const? (-1))))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_invert_signbit_splat_mask2_thm (e : IntW 16) (e_1 : IntW 8) :
  LLVM.and (sext 16 (LLVM.xor (ashr e_1 (const? 6)) (const? (-1)))) e ⊑
    LLVM.and e (sext 16 (LLVM.xor (ashr e_1 (const? 6)) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_pow2_const_case1_thm (e : IntW 16) :
  LLVM.and (lshr (shl (const? 4) e) (const? 6)) (const? 8) ⊑
    select (icmp IntPredicate.eq e (const? 7)) (const? 8) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_ashr_pow2_const_case1_thm (e : IntW 16) :
  LLVM.and (ashr (shl (const? 4) e) (const? 6)) (const? 8) ⊑
    select (icmp IntPredicate.eq e (const? 7)) (const? 8) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_pow2_const_case2_thm (e : IntW 16) :
  LLVM.and (lshr (shl (const? 16) e) (const? 3)) (const? 8) ⊑
    select (icmp IntPredicate.eq e (const? 2)) (const? 8) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_pow2_not_const_case2_thm (e : IntW 16) :
  LLVM.xor (LLVM.and (lshr (shl (const? 16) e) (const? 3)) (const? 8)) (const? 8) ⊑
    select (icmp IntPredicate.eq e (const? 2)) (const? 0) (const? 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_pow2_const_negative_overflow1_thm (e : IntW 16) : LLVM.and (lshr (shl (const? 4096) e) (const? 6)) (const? 8) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_pow2_const_negative_overflow2_thm (e : IntW 16) : LLVM.and (lshr (shl (const? 8) e) (const? 6)) (const? (-32768)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_lshr_pow2_const_thm (e : IntW 16) :
  LLVM.and (lshr (lshr (const? 2048) e) (const? 6)) (const? 4) ⊑
    select (icmp IntPredicate.eq e (const? 3)) (const? 4) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_lshr_pow2_const_negative_nopow2_1_thm (e : IntW 16) :
  LLVM.and (lshr (lshr (const? 2047) e) (const? 6)) (const? 4) ⊑ LLVM.and (lshr (const? 31) e) (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_lshr_pow2_const_negative_nopow2_2_thm (e : IntW 16) :
  LLVM.and (lshr (lshr (const? 8192) e) (const? 6)) (const? 3) ⊑ LLVM.and (lshr (const? 128) e) (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_lshr_pow2_const_negative_overflow_thm (e : IntW 16) :
  LLVM.and (lshr (lshr (const? (-32768)) e) (const? 15)) (const? 4) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_shl_pow2_const_case1_thm (e : IntW 16) :
  LLVM.and (shl (lshr (const? 256) e) (const? 2)) (const? 8) ⊑
    select (icmp IntPredicate.eq e (const? 7)) (const? 8) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_shl_pow2_const_xor_thm (e : IntW 16) :
  LLVM.xor (LLVM.and (shl (lshr (const? 256) e) (const? 2)) (const? 8)) (const? 8) ⊑
    select (icmp IntPredicate.eq e (const? 7)) (const? 0) (const? 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_shl_pow2_const_case2_thm (e : IntW 16) :
  LLVM.and (shl (lshr (const? 8192) e) (const? 4)) (const? 32) ⊑
    select (icmp IntPredicate.eq e (const? 12)) (const? 32) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_shl_pow2_const_overflow_thm (e : IntW 16) : LLVM.and (shl (lshr (const? 8192) e) (const? 6)) (const? 32) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negate_lowbitmask_thm (e e_1 : IntW 8) :
  LLVM.and (sub (const? 0) (LLVM.and e_1 (const? 1))) e ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 1)) (const? 0)) (const? 0) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.and e_1 (zext 32 e) ⊑ select e (LLVM.and e_1 (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_commuted_thm (e : IntW 32) (e_1 : IntW 1) :
  LLVM.and (zext 32 e_1) e ⊑ select e_1 (LLVM.and e (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_eq_even_thm (e : IntW 32) : LLVM.and e (zext 32 (icmp IntPredicate.eq e (const? 2))) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_eq_even_commuted_thm (e : IntW 32) : LLVM.and (zext 32 (icmp IntPredicate.eq e (const? 2))) e ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_eq_odd_thm (e : IntW 32) :
  LLVM.and e (zext 32 (icmp IntPredicate.eq e (const? 3))) ⊑ zext 32 (icmp IntPredicate.eq e (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_eq_odd_commuted_thm (e : IntW 32) :
  LLVM.and (zext 32 (icmp IntPredicate.eq e (const? 3))) e ⊑ zext 32 (icmp IntPredicate.eq e (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_eq_zero_thm (e e_1 : IntW 32) :
  LLVM.and (zext 32 (icmp IntPredicate.eq e_1 (const? 0))) (LLVM.xor (lshr e_1 e) (const? (-1))) ⊑
    zext 32 (icmp IntPredicate.eq e_1 (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_constant_equal_with_the_top_bit_of_demandedbits_pass_thm (e : IntW 32) :
  LLVM.and (add e (const? 16)) (const? 24) ⊑ LLVM.xor (LLVM.and e (const? 24)) (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.or (add e_1 (const? 16)) e) (const? 24) ⊑
    LLVM.and (LLVM.or (LLVM.xor e_1 (const? 16)) e) (const? 24) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_sext_multiuse_thm (e e_1 e_2 e_3 : IntW 32) :
  add (LLVM.and (sext 32 (icmp IntPredicate.sgt e_3 e_2)) e_1) (LLVM.and (sext 32 (icmp IntPredicate.sgt e_3 e_2)) e) ⊑
    select (icmp IntPredicate.sgt e_3 e_2) (add e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


