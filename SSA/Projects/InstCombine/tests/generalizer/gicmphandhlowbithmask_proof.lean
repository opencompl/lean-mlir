
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphandhlowbithmask_proof
theorem src_is_mask_zext_proof.src_is_mask_zext_thm_1 (e : IntW 16) (e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.and (LLVM.xor e (const? 16 123)) (zext 16 (lshr (const? 8 (-1)) e_1)))
      (LLVM.xor e (const? 16 123)) ⊑
    icmp IntPred.ule (LLVM.xor e (const? 16 123)) (zext 16 (lshr (const? 8 (-1)) e_1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_zext_fail_not_mask_proof.src_is_mask_zext_fail_not_mask_thm_1 (e : IntW 16) (e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.and (LLVM.xor e (const? 16 123)) (zext 16 (lshr (const? 8 (-2)) e_1)))
      (LLVM.xor e (const? 16 123)) ⊑
    icmp IntPred.eq (LLVM.or (LLVM.xor e (const? 16 (-124))) (zext 16 (lshr (const? 8 (-2)) e_1)))
      (const? 16 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_sext_proof.src_is_mask_sext_thm_1 (e : IntW 16) (e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.and (LLVM.xor (sext 16 (lshr (const? 8 31) e_1)) (const? 16 (-1))) (LLVM.xor e (const? 16 123)))
      (const? 16 0) ⊑
    icmp IntPred.ule (LLVM.xor e (const? 16 123)) (zext 16 (lshr (const? 8 31) e_1) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_and_proof.src_is_mask_and_thm_1 (e e_1 e_2 : IntW 8) :
  icmp IntPred.eq (LLVM.xor e (const? 8 123))
      (LLVM.and (LLVM.xor e (const? 8 123)) (LLVM.and (ashr (const? 8 7) e_1) (lshr (const? 8 (-1)) e_2))) ⊑
    icmp IntPred.ule (LLVM.xor e (const? 8 123)) (LLVM.and (lshr (const? 8 7) e_1) (lshr (const? 8 (-1)) e_2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_and_fail_mixed_proof.src_is_mask_and_fail_mixed_thm_1 (e e_1 e_2 : IntW 8) :
  icmp IntPred.eq (LLVM.xor e (const? 8 123))
      (LLVM.and (LLVM.xor e (const? 8 123)) (LLVM.and (ashr (const? 8 (-8)) e_1) (lshr (const? 8 (-1)) e_2))) ⊑
    icmp IntPred.eq
      (LLVM.or (LLVM.and (ashr (const? 8 (-8)) e_1) (lshr (const? 8 (-1)) e_2)) (LLVM.xor e (const? 8 (-124))))
      (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_or_proof.src_is_mask_or_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.xor e (const? 8 123))
      (LLVM.and (LLVM.and (lshr (const? 8 (-1)) e_1) (const? 8 7)) (LLVM.xor e (const? 8 123))) ⊑
    icmp IntPred.ule (LLVM.xor e (const? 8 123)) (LLVM.and (lshr (const? 8 (-1)) e_1) (const? 8 7)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_xor_proof.src_is_mask_xor_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.and (LLVM.xor e (const? 8 123)) (LLVM.xor e_1 (add e_1 (const? 8 (-1)))))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPred.ugt (LLVM.xor e (const? 8 123)) (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_xor_fail_notmask_proof.src_is_mask_xor_fail_notmask_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne
      (LLVM.and (LLVM.xor e (const? 8 123)) (LLVM.xor (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 (-1))))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPred.ne (LLVM.or (LLVM.xor e_1 (sub (const? 8 0) e_1)) (LLVM.xor e (const? 8 (-124))))
      (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_select_proof.src_is_mask_select_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.ne
      (LLVM.and (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) (LLVM.xor e (const? 8 123)))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPred.ugt (LLVM.xor e (const? 8 123))
      (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_shl_lshr_proof.src_is_mask_shl_lshr_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (const? 8 0)
      (LLVM.and (LLVM.xor e (const? 8 123)) (LLVM.xor (lshr (shl (const? 8 (-1)) e_1) e_1) (const? 8 (-1)))) ⊑
    icmp IntPred.ugt (LLVM.xor e (const? 8 122)) (lshr (const? 8 (-1)) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_shl_lshr_fail_not_allones_proof.src_is_mask_shl_lshr_fail_not_allones_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (const? 8 0)
      (LLVM.and (LLVM.xor e (const? 8 123)) (LLVM.xor (lshr (shl (const? 8 (-2)) e_1) e_1) (const? 8 (-1)))) ⊑
    icmp IntPred.ne (LLVM.or (LLVM.xor e (const? 8 (-124))) (LLVM.and (lshr (const? 8 (-1)) e_1) (const? 8 (-2))))
      (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_lshr_proof.src_is_mask_lshr_thm_1 (e e_1 e_2 : IntW 8) (e_3 : IntW 1) :
  icmp IntPred.ne (LLVM.xor e (const? 8 123))
      (LLVM.and (lshr (select e_3 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) e_2)
        (LLVM.xor e (const? 8 123))) ⊑
    icmp IntPred.ugt (LLVM.xor e (const? 8 123))
      (lshr (select e_3 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_ashr_proof.src_is_mask_ashr_thm_1 (e e_1 e_2 : IntW 8) (e_3 : IntW 1) :
  icmp IntPred.ult
      (LLVM.and (LLVM.xor e (const? 8 123))
        (ashr (select e_3 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) e_2))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPred.ugt (LLVM.xor e (const? 8 123))
      (ashr (select e_3 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_p2_m1_proof.src_is_mask_p2_m1_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ult (LLVM.and (add (shl (const? 8 2) e_1) (const? 8 (-1))) (LLVM.xor e (const? 8 123)))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPred.ugt (LLVM.xor e (const? 8 123)) (add (shl (const? 8 2) e_1) (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_notmask_sext_proof.src_is_notmask_sext_thm_1 (e : IntW 16) (e_1 : IntW 8) :
  icmp IntPred.ule (LLVM.xor e (const? 16 123))
      (LLVM.and (LLVM.xor (sext 16 (shl (const? 8 (-8)) e_1)) (const? 16 (-1))) (LLVM.xor e (const? 16 123))) ⊑
    icmp IntPred.uge (LLVM.xor e (const? 16 (-128))) (sext 16 (shl (const? 8 (-8)) e_1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_notmask_x_xor_neg_x_proof.src_is_notmask_x_xor_neg_x_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.eq
      (LLVM.and (LLVM.xor e (const? 8 123)) (select e_2 (LLVM.xor e_1 (sub (const? 8 0) e_1)) (const? 8 (-8))))
      (const? 8 0) ⊑
    icmp IntPred.ule (LLVM.xor e (const? 8 123))
      (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 7)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_notmask_x_xor_neg_x_inv_proof.src_is_notmask_x_xor_neg_x_inv_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.eq
      (LLVM.and (select e_2 (LLVM.xor e_1 (sub (const? 8 0) e_1)) (const? 8 (-8))) (LLVM.xor e (const? 8 123)))
      (const? 8 0) ⊑
    icmp IntPred.ule (LLVM.xor e (const? 8 123))
      (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 7)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_notmask_lshr_shl_proof.src_is_notmask_lshr_shl_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.and (LLVM.xor (shl (lshr (const? 8 (-1)) e_1) e_1) (const? 8 (-1))) (LLVM.xor e (const? 8 123)))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPred.uge (LLVM.xor e (const? 8 (-124))) (shl (const? 8 (-1)) e_1 { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_notmask_lshr_shl_fail_mismatch_shifts_proof.src_is_notmask_lshr_shl_fail_mismatch_shifts_thm_1 (e e_1 e_2 : IntW 8) :
  icmp IntPred.eq (LLVM.and (LLVM.xor (shl (lshr (const? 8 (-1)) e_1) e_2) (const? 8 (-1))) (LLVM.xor e (const? 8 123)))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPred.eq (LLVM.and (LLVM.xor e (const? 8 123)) (shl (lshr (const? 8 (-1)) e_1) e_2)) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_notmask_ashr_proof.src_is_notmask_ashr_thm_1 (e : IntW 16) (e_1 : IntW 8) (e_2 : IntW 16) :
  icmp IntPred.eq (LLVM.xor e (const? 16 123))
      (LLVM.and (LLVM.xor e (const? 16 123))
        (LLVM.xor (ashr (sext 16 (shl (const? 8 (-32)) e_1)) e_2) (const? 16 (-1)))) ⊑
    icmp IntPred.uge (LLVM.xor e (const? 16 (-124))) (ashr (sext 16 (shl (const? 8 (-32)) e_1)) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_notmask_neg_p2_fail_not_invertable_proof.src_is_notmask_neg_p2_fail_not_invertable_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (const? 8 0)
      (LLVM.and (sub (const? 8 0) (LLVM.and (sub (const? 8 0) e_1) e_1)) (LLVM.xor e (const? 8 123))) ⊑
    icmp IntPred.uge (LLVM.xor e (const? 8 (-124))) (LLVM.or e_1 (sub (const? 8 0) e_1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_const_slt_proof.src_is_mask_const_slt_thm_1 (e : IntW 8) :
  icmp IntPred.slt (LLVM.xor e (const? 8 123)) (LLVM.and (LLVM.xor e (const? 8 123)) (const? 8 7)) ⊑
    icmp IntPred.slt e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_const_sgt_proof.src_is_mask_const_sgt_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (LLVM.xor e (const? 8 123)) (LLVM.and (LLVM.xor e (const? 8 123)) (const? 8 7)) ⊑
    icmp IntPred.sgt (LLVM.xor e (const? 8 123)) (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_const_sle_proof.src_is_mask_const_sle_thm_1 (e : IntW 8) :
  icmp IntPred.sle (LLVM.and (LLVM.xor e (const? 8 123)) (const? 8 31)) (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPred.sgt e (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_is_mask_const_sge_proof.src_is_mask_const_sge_thm_1 (e : IntW 8) :
  icmp IntPred.sge (LLVM.and (LLVM.xor e (const? 8 123)) (const? 8 31)) (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPred.slt (LLVM.xor e (const? 8 123)) (const? 8 32) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_x_and_nmask_eq_proof.src_x_and_nmask_eq_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.eq (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0))
      (LLVM.and e (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0))) ⊑
    select (LLVM.xor e_2 (const? 1 1)) (const? 1 1)
      (icmp IntPred.ule (shl (const? 8 (-1)) e_1 { «nsw» := true }) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_x_and_nmask_ne_proof.src_x_and_nmask_ne_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.ne (LLVM.and e (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0)))
      (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0)) ⊑
    select e_2 (icmp IntPred.ugt (shl (const? 8 (-1)) e_1 { «nsw» := true }) e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_x_and_nmask_ult_proof.src_x_and_nmask_ult_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.ult (LLVM.and e (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0)))
      (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0)) ⊑
    select e_2 (icmp IntPred.ugt (shl (const? 8 (-1)) e_1 { «nsw» := true }) e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_x_and_nmask_uge_proof.src_x_and_nmask_uge_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.uge (LLVM.and e (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0)))
      (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0)) ⊑
    select (LLVM.xor e_2 (const? 1 1)) (const? 1 1)
      (icmp IntPred.ule (shl (const? 8 (-1)) e_1 { «nsw» := true }) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_x_and_nmask_slt_proof.src_x_and_nmask_slt_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.slt (LLVM.and e (shl (const? 8 (-1)) e_1)) (shl (const? 8 (-1)) e_1) ⊑
    icmp IntPred.sgt (shl (const? 8 (-1)) e_1 { «nsw» := true }) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_x_and_nmask_sge_proof.src_x_and_nmask_sge_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.sge (LLVM.and e (shl (const? 8 (-1)) e_1)) (shl (const? 8 (-1)) e_1) ⊑
    icmp IntPred.sle (shl (const? 8 (-1)) e_1 { «nsw» := true }) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_x_and_nmask_slt_fail_maybe_z_proof.src_x_and_nmask_slt_fail_maybe_z_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.slt (LLVM.and e (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0)))
      (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0)) ⊑
    icmp IntPred.slt (LLVM.and e (select e_2 (shl (const? 8 (-1)) e_1 { «nsw» := true }) (const? 8 0)))
      (select e_2 (shl (const? 8 (-1)) e_1 { «nsw» := true }) (const? 8 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_x_and_nmask_sge_fail_maybe_z_proof.src_x_and_nmask_sge_fail_maybe_z_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.sge (LLVM.and e (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0)))
      (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0)) ⊑
    icmp IntPred.sge (LLVM.and e (select e_2 (shl (const? 8 (-1)) e_1 { «nsw» := true }) (const? 8 0)))
      (select e_2 (shl (const? 8 (-1)) e_1 { «nsw» := true }) (const? 8 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_x_or_mask_ne_proof.src_x_or_mask_ne_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.ne (LLVM.or (select e_2 (lshr (const? 8 (-1)) e_1) (const? 8 0)) (LLVM.xor e (const? 8 (-1))))
      (const? 8 (-1)) ⊑
    icmp IntPred.ugt e (select e_2 (lshr (const? 8 (-1)) e_1) (const? 8 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
