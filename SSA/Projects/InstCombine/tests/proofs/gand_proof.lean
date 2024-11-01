
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gand_proof
theorem test_with_even_thm (e✝ : IntW 32) : LLVM.and (shl (const? 4) e✝) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_with_neg_even_thm (e✝ : IntW 32) : LLVM.and (shl (const? (-4)) e✝) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test1_thm (e✝ : IntW 32) : LLVM.and e✝ (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ : IntW 32) : LLVM.and e✝ (const? (-1)) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e✝ : IntW 1) : LLVM.and e✝ (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_logical_thm (e✝ : IntW 1) : select e✝ (const? 0) (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e✝ : IntW 1) : LLVM.and e✝ (const? 1) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_logical_thm (e✝ : IntW 1) : select e✝ (const? 1) (const? 0) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e✝ : IntW 32) : LLVM.and e✝ e✝ ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm (e✝ : IntW 1) : LLVM.and e✝ e✝ ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_logical_thm (e✝ : IntW 1) : select e✝ e✝ (const? 0) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e✝ : IntW 32) : LLVM.and e✝ (LLVM.xor e✝ (const? (-1))) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm (e✝ : IntW 8) : LLVM.and (LLVM.and e✝ (const? 3)) (const? 4) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm (e✝ : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.and e✝ (const? 12)) (const? 15)) (const? 1) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15_thm (e✝ : IntW 8) : LLVM.and (lshr e✝ (const? 7)) (const? 2) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test16_thm (e✝ : IntW 8) : LLVM.and (shl e✝ (const? 2)) (const? 3) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test19_thm (e✝ : IntW 32) : LLVM.and (shl e✝ (const? 3)) (const? (-2)) ⊑ shl e✝ (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test20_thm (e✝ : IntW 8) : LLVM.and (lshr e✝ (const? 7)) (const? 1) ⊑ lshr e✝ (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test27_thm (e✝ : IntW 8) :
  add (LLVM.and (sub (LLVM.and e✝ (const? 4)) (const? 16)) (const? (-16))) (const? 16) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_lowmask_thm (e✝ : IntW 32) : LLVM.and (ashr e✝ (const? 24)) (const? 255) ⊑ lshr e✝ (const? 24) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test29_thm (e✝ : IntW 8) : LLVM.and (zext 32 e✝) (const? 255) ⊑ zext 32 e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test30_thm (e✝ : IntW 1) : LLVM.and (zext 32 e✝) (const? 1) ⊑ zext 32 e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test31_thm (e✝ : IntW 1) :
  LLVM.and (shl (zext 32 e✝) (const? 4)) (const? 16) ⊑ select e✝ (const? 16) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_demanded_thm (e✝ : IntW 16) (e✝¹ : IntW 32) :
  LLVM.and (LLVM.or e✝¹ (const? 255)) (zext 32 (lshr e✝ (const? 8))) ⊑ zext 32 (lshr e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test32_thm (e✝ : IntW 32) : LLVM.and (lshr (LLVM.and e✝ (const? 16)) (const? 2)) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test33_thm (e✝ : IntW 32) :
  LLVM.or (LLVM.and e✝ (const? (-2))) (LLVM.xor (LLVM.and e✝ (const? 1)) (const? 1)) ⊑ LLVM.xor e✝ (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test33b_thm (e✝ : IntW 32) :
  LLVM.or (LLVM.xor (LLVM.and e✝ (const? 1)) (const? 1)) (LLVM.and e✝ (const? (-2))) ⊑ LLVM.xor e✝ (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test34_thm (e✝ e✝¹ : IntW 32) : LLVM.and (LLVM.or e✝¹ e✝) e✝¹ ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test35_thm (e✝ : IntW 32) :
  LLVM.and (sub (const? 0) (zext 64 e✝)) (const? 240) ⊑ zext 64 (LLVM.and (sub (const? 0) e✝) (const? 240)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test36_thm (e✝ : IntW 32) :
  LLVM.and (add (zext 64 e✝) (const? 7)) (const? 240) ⊑ zext 64 (LLVM.and (add e✝ (const? 7)) (const? 240)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test37_thm (e✝ : IntW 32) :
  LLVM.and (mul (zext 64 e✝) (const? 7)) (const? 240) ⊑ zext 64 (LLVM.and (mul e✝ (const? 7)) (const? 240)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test38_thm (e✝ : IntW 32) :
  LLVM.and (LLVM.xor (zext 64 e✝) (const? 7)) (const? 240) ⊑ zext 64 (LLVM.and e✝ (const? 240)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test39_thm (e✝ : IntW 32) :
  LLVM.and (LLVM.or (zext 64 e✝) (const? 7)) (const? 240) ⊑ zext 64 (LLVM.and e✝ (const? 240)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_add_zext_thm (e✝ : IntW 32) (e✝¹ : IntW 8) :
  LLVM.and (add (zext 32 e✝¹) e✝) (const? 255) ⊑ zext 32 (add e✝¹ (trunc 8 e✝)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_add_zext_commute_thm (e✝ : IntW 16) (e✝¹ : IntW 32) :
  LLVM.and (add (mul e✝¹ e✝¹) (zext 32 e✝)) (const? 65535) ⊑ zext 32 (add e✝ (trunc 16 (mul e✝¹ e✝¹))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_add_zext_wrong_mask_thm (e✝ : IntW 32) (e✝¹ : IntW 8) :
  LLVM.and (add (zext 32 e✝¹) e✝) (const? 511) ⊑ LLVM.and (add e✝ (zext 32 e✝¹)) (const? 511) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_sub_zext_commute_thm (e✝ : IntW 5) (e✝¹ : IntW 17) :
  LLVM.and (sub e✝¹ (zext 17 e✝)) (const? 31) ⊑ zext 17 (sub (trunc 5 e✝¹) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_mul_zext_thm (e✝ : IntW 32) (e✝¹ : IntW 8) :
  LLVM.and (mul (zext 32 e✝¹) e✝) (const? 255) ⊑ zext 32 (mul e✝¹ (trunc 8 e✝)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_xor_zext_commute_thm (e✝ : IntW 8) (e✝¹ : IntW 32) :
  LLVM.and (LLVM.xor (mul e✝¹ e✝¹) (zext 32 e✝)) (const? 255) ⊑ zext 32 (LLVM.xor e✝ (trunc 8 (mul e✝¹ e✝¹))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_or_zext_commute_thm (e✝ : IntW 16) (e✝¹ : IntW 24) :
  LLVM.and (LLVM.or e✝¹ (zext 24 e✝)) (const? 65535) ⊑ zext 24 (LLVM.or e✝ (trunc 16 e✝¹)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test40_thm (e✝ : IntW 1) :
  LLVM.and (select e✝ (const? 1000) (const? 10)) (const? 123) ⊑ select e✝ (const? 104) (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test42_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.xor (LLVM.xor e✝² (const? (-1))) (mul e✝¹ e✝)) (LLVM.or e✝² (mul e✝¹ e✝)) ⊑
    LLVM.and (mul e✝¹ e✝) e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test43_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or e✝² (mul e✝¹ e✝)) (LLVM.xor (LLVM.xor e✝² (const? (-1))) (mul e✝¹ e✝)) ⊑
    LLVM.and (mul e✝¹ e✝) e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test44_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor e✝¹ (const? (-1))) e✝) e✝¹ ⊑ LLVM.and e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test45_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1)))) e✝ ⊑ LLVM.and e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test46_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and e✝¹ (LLVM.or (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑ LLVM.and e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test47_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and e✝¹ (LLVM.or e✝ (LLVM.xor e✝¹ (const? (-1)))) ⊑ LLVM.and e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowbitmask_casted_shift_thm (e✝ : IntW 8) :
  LLVM.and (sext 32 (ashr e✝ (const? 1))) (const? 2147483647) ⊑ lshr (sext 32 e✝) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lowmask_add_2_thm (e✝ : IntW 8) : LLVM.and (add e✝ (const? (-64))) (const? 63) ⊑ LLVM.and e✝ (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem flip_masked_bit_thm (e✝ : IntW 8) :
  LLVM.and (add e✝ (const? 16)) (const? 16) ⊑ LLVM.xor (LLVM.and e✝ (const? 16)) (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_signbit_splat_mask1_thm (e✝ : IntW 16) (e✝¹ : IntW 8) :
  LLVM.and (zext 16 (ashr e✝¹ (const? 7))) e✝ ⊑ LLVM.and e✝ (zext 16 (ashr e✝¹ (const? 7))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_signbit_splat_mask2_thm (e✝ : IntW 16) (e✝¹ : IntW 8) :
  LLVM.and (sext 16 (ashr e✝¹ (const? 6))) e✝ ⊑ LLVM.and e✝ (sext 16 (ashr e✝¹ (const? 6))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_ashr_not_bitwidth_mask_thm (e✝ e✝¹ : IntW 8) :
  LLVM.and (LLVM.xor (ashr e✝¹ (const? 6)) (const? (-1))) e✝ ⊑
    LLVM.and e✝ (LLVM.xor (ashr e✝¹ (const? 6)) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_lshr_bitwidth_mask_thm (e✝ e✝¹ : IntW 8) :
  LLVM.and (LLVM.xor (lshr e✝¹ (const? 7)) (const? (-1))) e✝ ⊑
    LLVM.and e✝ (LLVM.xor (lshr e✝¹ (const? 7)) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_invert_signbit_splat_mask2_thm (e✝ : IntW 16) (e✝¹ : IntW 8) :
  LLVM.and (sext 16 (LLVM.xor (ashr e✝¹ (const? 6)) (const? (-1)))) e✝ ⊑
    LLVM.and e✝ (sext 16 (LLVM.xor (ashr e✝¹ (const? 6)) (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_pow2_const_negative_overflow1_thm (e✝ : IntW 16) : LLVM.and (lshr (shl (const? 4096) e✝) (const? 6)) (const? 8) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_pow2_const_negative_overflow2_thm (e✝ : IntW 16) :
  LLVM.and (lshr (shl (const? 8) e✝) (const? 6)) (const? (-32768)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_lshr_pow2_const_negative_nopow2_1_thm (e✝ : IntW 16) :
  LLVM.and (lshr (lshr (const? 2047) e✝) (const? 6)) (const? 4) ⊑ LLVM.and (lshr (const? 31) e✝) (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_lshr_pow2_const_negative_nopow2_2_thm (e✝ : IntW 16) :
  LLVM.and (lshr (lshr (const? 8192) e✝) (const? 6)) (const? 3) ⊑ LLVM.and (lshr (const? 128) e✝) (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_lshr_pow2_const_negative_overflow_thm (e✝ : IntW 16) :
  LLVM.and (lshr (lshr (const? (-32768)) e✝) (const? 15)) (const? 4) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_shl_pow2_const_overflow_thm (e✝ : IntW 16) : LLVM.and (shl (lshr (const? 8192) e✝) (const? 6)) (const? 32) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_thm (e✝ : IntW 1) (e✝¹ : IntW 32) :
  LLVM.and e✝¹ (zext 32 e✝) ⊑ select e✝ (LLVM.and e✝¹ (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_zext_commuted_thm (e✝ : IntW 32) (e✝¹ : IntW 1) :
  LLVM.and (zext 32 e✝¹) e✝ ⊑ select e✝¹ (LLVM.and e✝ (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_constant_equal_with_the_top_bit_of_demandedbits_pass_thm (e✝ : IntW 32) :
  LLVM.and (add e✝ (const? 16)) (const? 24) ⊑ LLVM.xor (LLVM.and e✝ (const? 24)) (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.or (add e✝¹ (const? 16)) e✝) (const? 24) ⊑
    LLVM.and (LLVM.or (LLVM.xor e✝¹ (const? 16)) e✝) (const? 24) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


