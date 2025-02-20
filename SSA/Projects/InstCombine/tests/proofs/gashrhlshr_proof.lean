
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gashrhlshr_proof
theorem ashr_lshr_exact_ashr_only_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt e_1 (const? 32 (-1))) (lshr e_1 e) (ashr e_1 e { «exact» := true }) ⊑
    ashr e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_no_exact_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt e_1 (const? 32 (-1))) (lshr e_1 e) (ashr e_1 e) ⊑ ashr e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_exact_both_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt e_1 (const? 32 (-1))) (lshr e_1 e { «exact» := true })
      (ashr e_1 e { «exact» := true }) ⊑
    ashr e_1 e { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_exact_lshr_only_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt e_1 (const? 32 (-1))) (lshr e_1 e { «exact» := true }) (ashr e_1 e) ⊑
    ashr e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr2_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt e_1 (const? 32 5)) (lshr e_1 e) (ashr e_1 e { «exact» := true }) ⊑ ashr e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr2_i128_thm (e e_1 : IntW 128) :
  select (icmp IntPredicate.sgt e_1 (const? 128 5)) (lshr e_1 e) (ashr e_1 e { «exact» := true }) ⊑ ashr e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_cst_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 32 1)) (ashr e (const? 32 8) { «exact» := true }) (lshr e (const? 32 8)) ⊑
    ashr e (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_cst2_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt e (const? 32 (-1))) (lshr e (const? 32 8)) (ashr e (const? 32 8) { «exact» := true }) ⊑
    ashr e (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_inv_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.slt e_1 (const? 32 1)) (ashr e_1 e { «exact» := true }) (lshr e_1 e) ⊑ ashr e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_inv2_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.slt e_1 (const? 32 7)) (ashr e_1 e { «exact» := true }) (lshr e_1 e) ⊑ ashr e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_wrong_cond_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sge e_1 (const? 32 (-1))) (lshr e_1 e) (ashr e_1 e) ⊑
    select (icmp IntPredicate.sgt e_1 (const? 32 (-2))) (lshr e_1 e) (ashr e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_shift_wrong_pred_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sle e_1 (const? 32 0)) (lshr e_1 e) (ashr e_1 e) ⊑
    select (icmp IntPredicate.slt e_1 (const? 32 1)) (lshr e_1 e) (ashr e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_shift_wrong_pred2_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.sge e_2 (const? 32 0)) (lshr e_1 e) (ashr e_1 e) ⊑
    select (icmp IntPredicate.slt e_2 (const? 32 0)) (ashr e_1 e) (lshr e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_wrong_operands_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sge e_1 (const? 32 0)) (ashr e_1 e) (lshr e_1 e) ⊑
    select (icmp IntPredicate.slt e_1 (const? 32 0)) (lshr e_1 e) (ashr e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_no_ashr_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sge e_1 (const? 32 0)) (lshr e_1 e) (LLVM.xor e_1 e) ⊑
    select (icmp IntPredicate.slt e_1 (const? 32 0)) (LLVM.xor e_1 e) (lshr e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_shift_amt_mismatch_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.sge e_2 (const? 32 0)) (lshr e_2 e_1) (ashr e_2 e) ⊑
    select (icmp IntPredicate.slt e_2 (const? 32 0)) (ashr e_2 e) (lshr e_2 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_shift_base_mismatch_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.sge e_2 (const? 32 0)) (lshr e_2 e_1) (ashr e e_1) ⊑
    select (icmp IntPredicate.slt e_2 (const? 32 0)) (ashr e e_1) (lshr e_2 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_lshr_no_lshr_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sge e_1 (const? 32 0)) (add e_1 e) (ashr e_1 e) ⊑
    select (icmp IntPredicate.slt e_1 (const? 32 0)) (ashr e_1 e) (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_sub_nsw_thm (e e_1 : IntW 32) :
  lshr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 32 31) ⊑ zext 32 (icmp IntPredicate.slt e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_sub_nsw_thm (e e_1 : IntW 17) :
  ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 17 16) ⊑ sext 17 (icmp IntPredicate.slt e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_known_pos_exact_thm (e e_1 : IntW 8) :
  ashr (LLVM.and e_1 (const? 8 127)) e { «exact» := true } ⊑
    lshr (LLVM.and e_1 (const? 8 127)) e { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_mul_times_3_div_2_thm (e : IntW 32) :
  lshr (mul e (const? 32 3) { «nsw» := true, «nuw» := true }) (const? 32 1) ⊑
    add e (lshr e (const? 32 1)) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_mul_times_3_div_2_exact_thm (e : IntW 32) :
  lshr (mul e (const? 32 3) { «nsw» := true, «nuw» := false }) (const? 32 1) { «exact» := true } ⊑
    add e (lshr e (const? 32 1) { «exact» := true }) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_mul_times_3_div_2_exact_2_thm (e : IntW 32) :
  lshr (mul e (const? 32 3) { «nsw» := false, «nuw» := true }) (const? 32 1) { «exact» := true } ⊑
    add e (lshr e (const? 32 1) { «exact» := true }) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_mul_times_5_div_4_thm (e : IntW 32) :
  lshr (mul e (const? 32 5) { «nsw» := true, «nuw» := true }) (const? 32 2) ⊑
    add e (lshr e (const? 32 2)) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_mul_times_5_div_4_exact_thm (e : IntW 32) :
  lshr (mul e (const? 32 5) { «nsw» := true, «nuw» := false }) (const? 32 2) { «exact» := true } ⊑
    add e (lshr e (const? 32 2) { «exact» := true }) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_mul_times_5_div_4_exact_2_thm (e : IntW 32) :
  lshr (mul e (const? 32 5) { «nsw» := false, «nuw» := true }) (const? 32 2) { «exact» := true } ⊑
    add e (lshr e (const? 32 2) { «exact» := true }) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_mul_times_3_div_2_thm (e : IntW 32) :
  ashr (mul e (const? 32 3) { «nsw» := true, «nuw» := true }) (const? 32 1) ⊑
    add e (lshr e (const? 32 1)) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_mul_times_3_div_2_exact_thm (e : IntW 32) :
  ashr (mul e (const? 32 3) { «nsw» := true, «nuw» := false }) (const? 32 1) { «exact» := true } ⊑
    add e (ashr e (const? 32 1) { «exact» := true }) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_mul_times_3_div_2_exact_2_thm (e : IntW 32) :
  ashr (mul e (const? 32 3) { «nsw» := true, «nuw» := false }) (const? 32 1) { «exact» := true } ⊑
    add e (ashr e (const? 32 1) { «exact» := true }) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_mul_times_5_div_4_thm (e : IntW 32) :
  ashr (mul e (const? 32 5) { «nsw» := true, «nuw» := true }) (const? 32 2) ⊑
    add e (lshr e (const? 32 2)) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_mul_times_5_div_4_exact_thm (e : IntW 32) :
  ashr (mul e (const? 32 5) { «nsw» := true, «nuw» := false }) (const? 32 2) { «exact» := true } ⊑
    add e (ashr e (const? 32 2) { «exact» := true }) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_mul_times_5_div_4_exact_2_thm (e : IntW 32) :
  ashr (mul e (const? 32 5) { «nsw» := true, «nuw» := false }) (const? 32 2) { «exact» := true } ⊑
    add e (ashr e (const? 32 2) { «exact» := true }) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lsb_mask_sign_zext_thm (e : IntW 32) :
  lshr (LLVM.and (add e (const? 32 (-1))) (LLVM.xor e (const? 32 (-1)))) (const? 32 31) ⊑
    zext 32 (icmp IntPredicate.eq e (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lsb_mask_sign_zext_commuted_thm (e : IntW 32) :
  lshr (LLVM.and (LLVM.xor e (const? 32 (-1))) (add e (const? 32 (-1)))) (const? 32 31) ⊑
    zext 32 (icmp IntPredicate.eq e (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lsb_mask_sign_zext_wrong_cst2_thm (e : IntW 32) :
  lshr (LLVM.and (add e (const? 32 (-1))) (LLVM.xor e (const? 32 2))) (const? 32 31) ⊑
    lshr (LLVM.and (add e (const? 32 (-1))) e) (const? 32 31) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lsb_mask_sign_sext_thm (e : IntW 32) :
  ashr (LLVM.and (add e (const? 32 (-1))) (LLVM.xor e (const? 32 (-1)))) (const? 32 31) ⊑
    sext 32 (icmp IntPredicate.eq e (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lsb_mask_sign_sext_commuted_thm (e : IntW 32) :
  ashr (LLVM.and (LLVM.xor e (const? 32 (-1))) (add e (const? 32 (-1)))) (const? 32 31) ⊑
    sext 32 (icmp IntPredicate.eq e (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lsb_mask_sign_sext_wrong_cst2_thm (e : IntW 32) :
  ashr (LLVM.and (add e (const? 32 (-1))) (LLVM.xor e (const? 32 2))) (const? 32 31) ⊑
    ashr (LLVM.and (add e (const? 32 (-1))) e) (const? 32 31) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
