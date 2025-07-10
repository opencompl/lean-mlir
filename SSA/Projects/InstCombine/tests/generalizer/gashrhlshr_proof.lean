
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gashrhlshr_proof
theorem ashr_lshr_exact_ashr_only_proof.ashr_lshr_exact_ashr_only_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 (-1))) (lshr e e_1) (ashr e e_1 { «exact» := true }) ⊑ ashr e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_no_exact_proof.ashr_lshr_no_exact_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 (-1))) (lshr e e_1) (ashr e e_1) ⊑ ashr e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_exact_both_proof.ashr_lshr_exact_both_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 (-1))) (lshr e e_1 { «exact» := true }) (ashr e e_1 { «exact» := true }) ⊑
    ashr e e_1 { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_exact_lshr_only_proof.ashr_lshr_exact_lshr_only_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 (-1))) (lshr e e_1 { «exact» := true }) (ashr e e_1) ⊑ ashr e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr2_proof.ashr_lshr2_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 5)) (lshr e e_1) (ashr e e_1 { «exact» := true }) ⊑ ashr e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr2_i128_proof.ashr_lshr2_i128_thm_1 (e e_1 : IntW 128) :
  select (icmp IntPred.sgt e (const? 128 5)) (lshr e e_1) (ashr e e_1 { «exact» := true }) ⊑ ashr e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_cst_proof.ashr_lshr_cst_thm_1 (e : IntW 32) :
  select (icmp IntPred.slt e (const? 32 1)) (ashr e (const? 32 8) { «exact» := true }) (lshr e (const? 32 8)) ⊑
    ashr e (const? 32 8) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_cst2_proof.ashr_lshr_cst2_thm_1 (e : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 (-1))) (lshr e (const? 32 8)) (ashr e (const? 32 8) { «exact» := true }) ⊑
    ashr e (const? 32 8) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_inv_proof.ashr_lshr_inv_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.slt e (const? 32 1)) (ashr e e_1 { «exact» := true }) (lshr e e_1) ⊑ ashr e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_inv2_proof.ashr_lshr_inv2_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.slt e (const? 32 7)) (ashr e e_1 { «exact» := true }) (lshr e e_1) ⊑ ashr e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_wrong_cond_proof.ashr_lshr_wrong_cond_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sge e (const? 32 (-1))) (lshr e e_1) (ashr e e_1) ⊑
    select (icmp IntPred.sgt e (const? 32 (-2))) (lshr e e_1) (ashr e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_shift_wrong_pred_proof.ashr_lshr_shift_wrong_pred_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sle e (const? 32 0)) (lshr e e_1) (ashr e e_1) ⊑
    select (icmp IntPred.slt e (const? 32 1)) (lshr e e_1) (ashr e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_shift_wrong_pred2_proof.ashr_lshr_shift_wrong_pred2_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.sge e_2 (const? 32 0)) (lshr e e_1) (ashr e e_1) ⊑
    select (icmp IntPred.slt e_2 (const? 32 0)) (ashr e e_1) (lshr e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_wrong_operands_proof.ashr_lshr_wrong_operands_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sge e (const? 32 0)) (ashr e e_1) (lshr e e_1) ⊑
    select (icmp IntPred.slt e (const? 32 0)) (lshr e e_1) (ashr e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_no_ashr_proof.ashr_lshr_no_ashr_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sge e (const? 32 0)) (lshr e e_1) (LLVM.xor e e_1) ⊑
    select (icmp IntPred.slt e (const? 32 0)) (LLVM.xor e e_1) (lshr e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_shift_amt_mismatch_proof.ashr_lshr_shift_amt_mismatch_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.sge e (const? 32 0)) (lshr e e_1) (ashr e e_2) ⊑
    select (icmp IntPred.slt e (const? 32 0)) (ashr e e_2) (lshr e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_shift_base_mismatch_proof.ashr_lshr_shift_base_mismatch_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.sge e (const? 32 0)) (lshr e e_1) (ashr e_2 e_1) ⊑
    select (icmp IntPred.slt e (const? 32 0)) (ashr e_2 e_1) (lshr e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_lshr_no_lshr_proof.ashr_lshr_no_lshr_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sge e (const? 32 0)) (add e e_1) (ashr e e_1) ⊑
    select (icmp IntPred.slt e (const? 32 0)) (ashr e e_1) (add e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_sub_nsw_proof.lshr_sub_nsw_thm_1 (e e_1 : IntW 32) :
  lshr (sub e e_1 { «nsw» := true }) (const? 32 31) ⊑ zext 32 (icmp IntPred.slt e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_sub_nsw_proof.ashr_sub_nsw_thm_1 (e e_1 : IntW 17) :
  ashr (sub e e_1 { «nsw» := true }) (const? 17 16) ⊑ sext 17 (icmp IntPred.slt e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_known_pos_exact_proof.ashr_known_pos_exact_thm_1 (e e_1 : IntW 8) :
  ashr (LLVM.and e (const? 8 127)) e_1 { «exact» := true } ⊑
    lshr (LLVM.and e (const? 8 127)) e_1 { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_mul_times_3_div_2_proof.lshr_mul_times_3_div_2_thm_1 (e : IntW 32) :
  lshr (mul e (const? 32 3) { «nsw» := true, «nuw» := true }) (const? 32 1) ⊑
    add e (lshr e (const? 32 1)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_mul_times_3_div_2_exact_proof.lshr_mul_times_3_div_2_exact_thm_1 (e : IntW 32) :
  lshr (mul e (const? 32 3) { «nsw» := true }) (const? 32 1) { «exact» := true } ⊑
    add e (lshr e (const? 32 1) { «exact» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_mul_times_3_div_2_exact_2_proof.lshr_mul_times_3_div_2_exact_2_thm_1 (e : IntW 32) :
  lshr (mul e (const? 32 3) { «nuw» := true }) (const? 32 1) { «exact» := true } ⊑
    add e (lshr e (const? 32 1) { «exact» := true }) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_mul_times_5_div_4_proof.lshr_mul_times_5_div_4_thm_1 (e : IntW 32) :
  lshr (mul e (const? 32 5) { «nsw» := true, «nuw» := true }) (const? 32 2) ⊑
    add e (lshr e (const? 32 2)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_mul_times_5_div_4_exact_proof.lshr_mul_times_5_div_4_exact_thm_1 (e : IntW 32) :
  lshr (mul e (const? 32 5) { «nsw» := true }) (const? 32 2) { «exact» := true } ⊑
    add e (lshr e (const? 32 2) { «exact» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_mul_times_5_div_4_exact_2_proof.lshr_mul_times_5_div_4_exact_2_thm_1 (e : IntW 32) :
  lshr (mul e (const? 32 5) { «nuw» := true }) (const? 32 2) { «exact» := true } ⊑
    add e (lshr e (const? 32 2) { «exact» := true }) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_mul_times_3_div_2_proof.ashr_mul_times_3_div_2_thm_1 (e : IntW 32) :
  ashr (mul e (const? 32 3) { «nsw» := true, «nuw» := true }) (const? 32 1) ⊑
    add e (lshr e (const? 32 1)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_mul_times_3_div_2_exact_proof.ashr_mul_times_3_div_2_exact_thm_1 (e : IntW 32) :
  ashr (mul e (const? 32 3) { «nsw» := true }) (const? 32 1) { «exact» := true } ⊑
    add e (ashr e (const? 32 1) { «exact» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_mul_times_3_div_2_exact_2_proof.ashr_mul_times_3_div_2_exact_2_thm_1 (e : IntW 32) :
  ashr (mul e (const? 32 3) { «nsw» := true }) (const? 32 1) { «exact» := true } ⊑
    add e (ashr e (const? 32 1) { «exact» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_mul_times_5_div_4_proof.ashr_mul_times_5_div_4_thm_1 (e : IntW 32) :
  ashr (mul e (const? 32 5) { «nsw» := true, «nuw» := true }) (const? 32 2) ⊑
    add e (lshr e (const? 32 2)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_mul_times_5_div_4_exact_proof.ashr_mul_times_5_div_4_exact_thm_1 (e : IntW 32) :
  ashr (mul e (const? 32 5) { «nsw» := true }) (const? 32 2) { «exact» := true } ⊑
    add e (ashr e (const? 32 2) { «exact» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_mul_times_5_div_4_exact_2_proof.ashr_mul_times_5_div_4_exact_2_thm_1 (e : IntW 32) :
  ashr (mul e (const? 32 5) { «nsw» := true }) (const? 32 2) { «exact» := true } ⊑
    add e (ashr e (const? 32 2) { «exact» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lsb_mask_sign_zext_proof.lsb_mask_sign_zext_thm_1 (e : IntW 32) :
  lshr (LLVM.and (add e (const? 32 (-1))) (LLVM.xor e (const? 32 (-1)))) (const? 32 31) ⊑
    zext 32 (icmp IntPred.eq e (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lsb_mask_sign_zext_commuted_proof.lsb_mask_sign_zext_commuted_thm_1 (e : IntW 32) :
  lshr (LLVM.and (LLVM.xor e (const? 32 (-1))) (add e (const? 32 (-1)))) (const? 32 31) ⊑
    zext 32 (icmp IntPred.eq e (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lsb_mask_sign_zext_wrong_cst2_proof.lsb_mask_sign_zext_wrong_cst2_thm_1 (e : IntW 32) :
  lshr (LLVM.and (add e (const? 32 (-1))) (LLVM.xor e (const? 32 2))) (const? 32 31) ⊑
    lshr (LLVM.and (add e (const? 32 (-1))) e) (const? 32 31) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lsb_mask_sign_sext_proof.lsb_mask_sign_sext_thm_1 (e : IntW 32) :
  ashr (LLVM.and (add e (const? 32 (-1))) (LLVM.xor e (const? 32 (-1)))) (const? 32 31) ⊑
    sext 32 (icmp IntPred.eq e (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lsb_mask_sign_sext_commuted_proof.lsb_mask_sign_sext_commuted_thm_1 (e : IntW 32) :
  ashr (LLVM.and (LLVM.xor e (const? 32 (-1))) (add e (const? 32 (-1)))) (const? 32 31) ⊑
    sext 32 (icmp IntPred.eq e (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lsb_mask_sign_sext_wrong_cst2_proof.lsb_mask_sign_sext_wrong_cst2_thm_1 (e : IntW 32) :
  ashr (LLVM.and (add e (const? 32 (-1))) (LLVM.xor e (const? 32 2))) (const? 32 31) ⊑
    ashr (LLVM.and (add e (const? 32 (-1))) e) (const? 32 31) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
