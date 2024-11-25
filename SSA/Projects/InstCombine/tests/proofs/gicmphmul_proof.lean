
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gicmphmul_proof
theorem squared_nsw_eq0_thm (e : IntW 5) :
  icmp IntPredicate.eq (mul e e { «nsw» := true, «nuw» := false }) (const? 5 0) ⊑
    icmp IntPredicate.eq e (const? 5 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem squared_nsw_sgt0_thm (e : IntW 5) :
  icmp IntPredicate.sgt (mul e e { «nsw» := true, «nuw» := false }) (const? 5 0) ⊑
    icmp IntPredicate.ne e (const? 5 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_positive_multip_rem_zero_thm (e : IntW 8) :
  icmp IntPredicate.slt (mul e (const? 8 7) { «nsw» := true, «nuw» := false }) (const? 8 21) ⊑
    icmp IntPredicate.slt e (const? 8 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_negative_multip_rem_zero_thm (e : IntW 8) :
  icmp IntPredicate.slt (mul e (const? 8 (-7)) { «nsw» := true, «nuw» := false }) (const? 8 21) ⊑
    icmp IntPredicate.sgt e (const? 8 (-3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_positive_multip_rem_nz_thm (e : IntW 8) :
  icmp IntPredicate.slt (mul e (const? 8 5) { «nsw» := true, «nuw» := false }) (const? 8 21) ⊑
    icmp IntPredicate.slt e (const? 8 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_rem_zero_thm (e : IntW 8) :
  icmp IntPredicate.ult (mul e (const? 8 7) { «nsw» := false, «nuw» := true }) (const? 8 21) ⊑
    icmp IntPredicate.ult e (const? 8 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_rem_zero_nsw_thm (e : IntW 8) :
  icmp IntPredicate.ult (mul e (const? 8 7) { «nsw» := true, «nuw» := true }) (const? 8 21) ⊑
    icmp IntPredicate.ult e (const? 8 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_rem_nz_thm (e : IntW 8) :
  icmp IntPredicate.ult (mul e (const? 8 5) { «nsw» := false, «nuw» := true }) (const? 8 21) ⊑
    icmp IntPredicate.ult e (const? 8 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_rem_nz_nsw_thm (e : IntW 8) :
  icmp IntPredicate.ult (mul e (const? 8 5) { «nsw» := true, «nuw» := true }) (const? 8 21) ⊑
    icmp IntPredicate.ult e (const? 8 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_positive_multip_rem_zero_thm (e : IntW 8) :
  icmp IntPredicate.sgt (mul e (const? 8 7) { «nsw» := true, «nuw» := false }) (const? 8 21) ⊑
    icmp IntPredicate.sgt e (const? 8 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_negative_multip_rem_zero_thm (e : IntW 8) :
  icmp IntPredicate.sgt (mul e (const? 8 (-7)) { «nsw» := true, «nuw» := false }) (const? 8 21) ⊑
    icmp IntPredicate.slt e (const? 8 (-3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_positive_multip_rem_nz_thm (e : IntW 8) :
  icmp IntPredicate.sgt (mul e (const? 8 5) { «nsw» := true, «nuw» := false }) (const? 8 21) ⊑
    icmp IntPredicate.sgt e (const? 8 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_rem_zero_thm (e : IntW 8) :
  icmp IntPredicate.ugt (mul e (const? 8 7) { «nsw» := false, «nuw» := true }) (const? 8 21) ⊑
    icmp IntPredicate.ugt e (const? 8 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_rem_zero_nsw_thm (e : IntW 8) :
  icmp IntPredicate.ugt (mul e (const? 8 7) { «nsw» := true, «nuw» := true }) (const? 8 21) ⊑
    icmp IntPredicate.ugt e (const? 8 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_rem_nz_thm (e : IntW 8) :
  icmp IntPredicate.ugt (mul e (const? 8 5) { «nsw» := false, «nuw» := true }) (const? 8 21) ⊑
    icmp IntPredicate.ugt e (const? 8 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_rem_nz_nsw_thm (e : IntW 8) :
  icmp IntPredicate.ugt (mul e (const? 8 5) { «nsw» := true, «nuw» := true }) (const? 8 21) ⊑
    icmp IntPredicate.ugt e (const? 8 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_nsw_rem_zero_thm (e : IntW 8) :
  icmp IntPredicate.eq (mul e (const? 8 (-5)) { «nsw» := true, «nuw» := false }) (const? 8 20) ⊑
    icmp IntPredicate.eq e (const? 8 (-4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_nsw_rem_nz_thm (e : IntW 8) :
  icmp IntPredicate.eq (mul e (const? 8 5) { «nsw» := true, «nuw» := false }) (const? 8 (-11)) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_nsw_rem_nz_thm (e : IntW 8) :
  icmp IntPredicate.ne (mul e (const? 8 5) { «nsw» := true, «nuw» := false }) (const? 8 (-126)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_nuw_rem_zero_thm (e : IntW 8) :
  icmp IntPredicate.ne (mul e (const? 8 5) { «nsw» := false, «nuw» := true }) (const? 8 (-126)) ⊑
    icmp IntPredicate.ne e (const? 8 26) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_nuw_rem_nz_thm (e : IntW 8) :
  icmp IntPredicate.eq (mul e (const? 8 (-5)) { «nsw» := false, «nuw» := true }) (const? 8 20) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_nuw_rem_nz_thm (e : IntW 8) :
  icmp IntPredicate.ne (mul e (const? 8 5) { «nsw» := false, «nuw» := true }) (const? 8 (-30)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_minnum_thm (e : IntW 8) :
  icmp IntPredicate.sgt (mul e (const? 8 7) { «nsw» := true, «nuw» := false }) (const? 8 (-128)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_bignum_thm (e : IntW 8) :
  icmp IntPredicate.ule (mul e (const? 8 (-1))) (const? 8 0) ⊑ icmp IntPredicate.eq e (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_mulzero_thm (e : IntW 8) :
  icmp IntPredicate.sgt (mul e (const? 8 0) { «nsw» := true, «nuw» := false }) (const? 8 21) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_rem_zero_nonuw_thm (e : IntW 8) :
  icmp IntPredicate.eq (mul e (const? 8 5)) (const? 8 20) ⊑ icmp IntPredicate.eq e (const? 8 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_rem_zero_nonuw_thm (e : IntW 8) :
  icmp IntPredicate.ne (mul e (const? 8 5)) (const? 8 30) ⊑ icmp IntPredicate.ne e (const? 8 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_constant_eq_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (mul e_1 (const? 32 5)) (mul e (const? 32 5)) ⊑ icmp IntPredicate.eq e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_constant_eq_nsw_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (mul e_1 (const? 32 6) { «nsw» := true, «nuw» := false })
      (mul e (const? 32 6) { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.eq e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_constant_nuw_eq_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (mul e_1 (const? 32 22) { «nsw» := false, «nuw» := true })
      (mul e (const? 32 22) { «nsw» := false, «nuw» := true }) ⊑
    icmp IntPredicate.eq e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_constant_partial_nuw_eq_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (mul e_1 (const? 32 44)) (mul e (const? 32 44) { «nsw» := false, «nuw» := true }) ⊑
    icmp IntPredicate.eq (LLVM.and (LLVM.xor e_1 e) (const? 32 1073741823)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_constant_mismatch_wrap_eq_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (mul e_1 (const? 32 54) { «nsw» := true, «nuw» := false })
      (mul e (const? 32 54) { «nsw» := false, «nuw» := true }) ⊑
    icmp IntPredicate.eq (LLVM.and (LLVM.xor e_1 e) (const? 32 2147483647)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_mul_constants_with_tz_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (mul e_1 (const? 32 12)) (mul e (const? 32 12)) ⊑
    icmp IntPredicate.ne (LLVM.and (LLVM.xor e_1 e) (const? 32 1073741823)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_bool_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 1)) (zext 32 e)) (const? 32 255) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_bool_commute_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 255)) (LLVM.and e (const? 32 1))) (const? 32 255) ⊑
    const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_bools_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ult (mul (LLVM.and e_1 (const? 32 1)) (LLVM.and e (const? 32 1))) (const? 32 2) ⊑
    const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_mul_of_bool_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 3)) (zext 32 e)) (const? 32 255) ⊑
    icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 3)) (zext 32 e) { «nsw» := true, «nuw» := true })
      (const? 32 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_mul_of_bool_commute_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 255)) (lshr e (const? 32 30))) (const? 32 255) ⊑
    icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 255)) (lshr e (const? 32 30)) { «nsw» := true, «nuw» := true })
      (const? 32 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_bool_no_lz_other_op_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.sgt (mul (LLVM.and e_1 (const? 32 1)) (sext 32 e) { «nsw» := true, «nuw» := true })
      (const? 32 127) ⊑
    const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_pow2_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 2)) (zext 32 e)) (const? 32 510) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_pow2_commute_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 255)) (LLVM.and e (const? 32 4))) (const? 32 1020) ⊑
    const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_pow2s_thm (e e_1 : IntW 32) :
  LLVM.or (mul (LLVM.and e_1 (const? 32 8)) (LLVM.and e (const? 32 16))) (const? 32 128) ⊑ const? 32 128 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_mul_of_pow2_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 6)) (zext 32 e)) (const? 32 1530) ⊑
    icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 6)) (zext 32 e) { «nsw» := true, «nuw» := true })
      (const? 32 1530) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_mul_of_pow2_commute_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ugt (mul (LLVM.and e_1 (const? 32 255)) (LLVM.and e (const? 32 12))) (const? 32 3060) ⊑
    icmp IntPredicate.ugt
      (mul (LLVM.and e_1 (const? 32 255)) (LLVM.and e (const? 32 12)) { «nsw» := true, «nuw» := true })
      (const? 32 3060) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem splat_mul_known_lz_thm (e : IntW 32) :
  icmp IntPredicate.eq (lshr (mul (zext 128 e) (const? 128 18446744078004518913)) (const? 128 96)) (const? 128 0) ⊑
    const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem splat_mul_unknown_lz_thm (e : IntW 32) :
  icmp IntPredicate.eq (lshr (mul (zext 128 e) (const? 128 18446744078004518913)) (const? 128 95)) (const? 128 0) ⊑
    icmp IntPredicate.sgt e (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem reused_mul_nuw_xy_z_selectnonzero_ugt_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne e_2 (const? 8 0))
      (icmp IntPredicate.ugt (mul e_1 e_2 { «nsw» := false, «nuw» := true })
        (mul e e_2 { «nsw» := false, «nuw» := true }))
      (const? 1 1) ⊑
    select (icmp IntPredicate.eq e_2 (const? 8 0)) (const? 1 1)
      (icmp IntPredicate.ugt (mul e_1 e_2 { «nsw» := false, «nuw» := true })
        (mul e e_2 { «nsw» := false, «nuw» := true })) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_mul_nsw_nonequal_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (mul e_1 e { «nsw» := true, «nuw» := false })
      (mul (add e_1 (const? 8 1)) e { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.eq e (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_mul_nuw_nonequal_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (mul e_1 e { «nsw» := false, «nuw» := true })
      (mul (add e_1 (const? 8 1)) e { «nsw» := false, «nuw» := true }) ⊑
    icmp IntPredicate.eq e (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_mul_nsw_nonequal_commuted_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (mul e_1 e { «nsw» := true, «nuw» := false })
      (mul e (add e_1 (const? 8 1)) { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.eq e (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_mul_nsw_nonequal_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (mul e_1 e { «nsw» := true, «nuw» := false })
      (mul (add e_1 (const? 8 1)) e { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.ne e (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_mul_nsw_slt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (mul e_1 (const? 8 7) { «nsw» := true, «nuw» := false })
      (mul e (const? 8 7) { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.slt e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_mul_nsw_sle_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sle (mul e_1 (const? 8 7) { «nsw» := true, «nuw» := false })
      (mul e (const? 8 7) { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.sle e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_mul_nsw_sgt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sgt (mul e_1 (const? 8 7) { «nsw» := true, «nuw» := false })
      (mul e (const? 8 7) { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.sgt e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_mul_nsw_sge_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sge (mul e_1 (const? 8 7) { «nsw» := true, «nuw» := false })
      (mul e (const? 8 7) { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.sge e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_mul_nsw_slt_neg_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (mul e_1 (const? 8 (-7)) { «nsw» := true, «nuw» := false })
      (mul e (const? 8 (-7)) { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.sgt e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


