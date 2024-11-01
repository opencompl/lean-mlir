
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphandhlowbithmask_proof
theorem src_is_mask_zext_thm (e : IntW 8) (e_1 : IntW 16) :
  icmp IntPredicate.eq (LLVM.and (LLVM.xor e_1 (const? 123)) (zext 16 (lshr (const? (-1)) e)))
      (LLVM.xor e_1 (const? 123)) ⊑
    icmp IntPredicate.ule (LLVM.xor e_1 (const? 123)) (zext 16 (lshr (const? (-1)) e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_zext_fail_not_mask_thm (e : IntW 8) (e_1 : IntW 16) :
  icmp IntPredicate.eq (LLVM.and (LLVM.xor e_1 (const? 123)) (zext 16 (lshr (const? (-2)) e)))
      (LLVM.xor e_1 (const? 123)) ⊑
    icmp IntPredicate.eq (LLVM.or (LLVM.xor e_1 (const? (-124))) (zext 16 (lshr (const? (-2)) e)))
      (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_sext_thm (e : IntW 16) (e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (LLVM.xor (sext 16 (lshr (const? 31) e_1)) (const? (-1))) (LLVM.xor e (const? 123)))
      (const? 0) ⊑
    icmp IntPredicate.ule (LLVM.xor e (const? 123)) (zext 16 (lshr (const? 31) e_1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_and_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.eq (LLVM.xor e_2 (const? 123))
      (LLVM.and (LLVM.xor e_2 (const? 123)) (LLVM.and (ashr (const? 7) e_1) (lshr (const? (-1)) e))) ⊑
    icmp IntPredicate.ule (LLVM.xor e_2 (const? 123)) (LLVM.and (lshr (const? 7) e_1) (lshr (const? (-1)) e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_and_fail_mixed_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.eq (LLVM.xor e_2 (const? 123))
      (LLVM.and (LLVM.xor e_2 (const? 123)) (LLVM.and (ashr (const? (-8)) e_1) (lshr (const? (-1)) e))) ⊑
    icmp IntPredicate.eq
      (LLVM.or (LLVM.and (ashr (const? (-8)) e_1) (lshr (const? (-1)) e)) (LLVM.xor e_2 (const? (-124))))
      (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_or_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.xor e_1 (const? 123))
      (LLVM.and (LLVM.and (lshr (const? (-1)) e) (const? 7)) (LLVM.xor e_1 (const? 123))) ⊑
    icmp IntPredicate.ule (LLVM.xor e_1 (const? 123)) (LLVM.and (lshr (const? (-1)) e) (const? 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_xor_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor e_1 (const? 123)) (LLVM.xor e (add e (const? (-1)))))
      (LLVM.xor e_1 (const? 123)) ⊑
    icmp IntPredicate.ugt (LLVM.xor e_1 (const? 123)) (LLVM.xor e (add e (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_xor_fail_notmask_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne
      (LLVM.and (LLVM.xor e_1 (const? 123)) (LLVM.xor (LLVM.xor e (add e (const? (-1)))) (const? (-1))))
      (LLVM.xor e_1 (const? 123)) ⊑
    icmp IntPredicate.ne (LLVM.or (LLVM.xor e (sub (const? 0) e)) (LLVM.xor e_1 (const? (-124)))) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_select_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.ne
      (LLVM.and (select e_2 (LLVM.xor e_1 (add e_1 (const? (-1)))) (const? 15)) (LLVM.xor e (const? 123)))
      (LLVM.xor e (const? 123)) ⊑
    icmp IntPredicate.ugt (LLVM.xor e (const? 123))
      (select e_2 (LLVM.xor e_1 (add e_1 (const? (-1)))) (const? 15)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_shl_lshr_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (const? 0)
      (LLVM.and (LLVM.xor e_1 (const? 123)) (LLVM.xor (lshr (shl (const? (-1)) e) e) (const? (-1)))) ⊑
    icmp IntPredicate.ugt (LLVM.xor e_1 (const? 122)) (lshr (const? (-1)) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_shl_lshr_fail_not_allones_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (const? 0)
      (LLVM.and (LLVM.xor e_1 (const? 123)) (LLVM.xor (lshr (shl (const? (-2)) e) e) (const? (-1)))) ⊑
    icmp IntPredicate.ne (LLVM.or (LLVM.xor e_1 (const? (-124))) (LLVM.and (lshr (const? (-1)) e) (const? (-2))))
      (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_lshr_thm (e e_1 : IntW 8) (e_2 : IntW 1) (e_3 : IntW 8) :
  icmp IntPredicate.ne (LLVM.xor e_3 (const? 123))
      (LLVM.and (lshr (select e_2 (LLVM.xor e_1 (add e_1 (const? (-1)))) (const? 15)) e) (LLVM.xor e_3 (const? 123))) ⊑
    icmp IntPredicate.ugt (LLVM.xor e_3 (const? 123))
      (lshr (select e_2 (LLVM.xor e_1 (add e_1 (const? (-1)))) (const? 15)) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_ashr_thm (e e_1 : IntW 8) (e_2 : IntW 1) (e_3 : IntW 8) :
  icmp IntPredicate.ult
      (LLVM.and (LLVM.xor e_3 (const? 123)) (ashr (select e_2 (LLVM.xor e_1 (add e_1 (const? (-1)))) (const? 15)) e))
      (LLVM.xor e_3 (const? 123)) ⊑
    icmp IntPredicate.ugt (LLVM.xor e_3 (const? 123))
      (ashr (select e_2 (LLVM.xor e_1 (add e_1 (const? (-1)))) (const? 15)) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_p2_m1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (LLVM.and (add (shl (const? 2) e_1) (const? (-1))) (LLVM.xor e (const? 123)))
      (LLVM.xor e (const? 123)) ⊑
    icmp IntPredicate.ugt (LLVM.xor e (const? 123)) (add (shl (const? 2) e_1) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_notmask_sext_thm (e : IntW 8) (e_1 : IntW 16) :
  icmp IntPredicate.ule (LLVM.xor e_1 (const? 123))
      (LLVM.and (LLVM.xor (sext 16 (shl (const? (-8)) e)) (const? (-1))) (LLVM.xor e_1 (const? 123))) ⊑
    icmp IntPredicate.uge (LLVM.xor e_1 (const? (-128))) (sext 16 (shl (const? (-8)) e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_notmask_x_xor_neg_x_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (LLVM.xor e_2 (const? 123)) (select e_1 (LLVM.xor e (sub (const? 0) e)) (const? (-8))))
      (const? 0) ⊑
    icmp IntPredicate.ule (LLVM.xor e_2 (const? 123))
      (select e_1 (LLVM.xor e (add e (const? (-1)))) (const? 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_notmask_x_xor_neg_x_inv_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.eq
      (LLVM.and (select e_2 (LLVM.xor e_1 (sub (const? 0) e_1)) (const? (-8))) (LLVM.xor e (const? 123))) (const? 0) ⊑
    icmp IntPredicate.ule (LLVM.xor e (const? 123))
      (select e_2 (LLVM.xor e_1 (add e_1 (const? (-1)))) (const? 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_notmask_lshr_shl_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (LLVM.xor (shl (lshr (const? (-1)) e_1) e_1) (const? (-1))) (LLVM.xor e (const? 123)))
      (LLVM.xor e (const? 123)) ⊑
    icmp IntPredicate.uge (LLVM.xor e (const? (-124)))
      (shl (const? (-1)) e_1 { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_notmask_lshr_shl_fail_mismatch_shifts_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (LLVM.xor (shl (lshr (const? (-1)) e_2) e_1) (const? (-1))) (LLVM.xor e (const? 123)))
      (LLVM.xor e (const? 123)) ⊑
    icmp IntPredicate.eq (LLVM.and (LLVM.xor e (const? 123)) (shl (lshr (const? (-1)) e_2) e_1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_notmask_ashr_thm (e : IntW 16) (e_1 : IntW 8) (e_2 : IntW 16) :
  icmp IntPredicate.eq (LLVM.xor e_2 (const? 123))
      (LLVM.and (LLVM.xor e_2 (const? 123)) (LLVM.xor (ashr (sext 16 (shl (const? (-32)) e_1)) e) (const? (-1)))) ⊑
    icmp IntPredicate.uge (LLVM.xor e_2 (const? (-124))) (ashr (sext 16 (shl (const? (-32)) e_1)) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_notmask_neg_p2_fail_not_invertable_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (const? 0)
      (LLVM.and (sub (const? 0) (LLVM.and (sub (const? 0) e_1) e_1)) (LLVM.xor e (const? 123))) ⊑
    icmp IntPredicate.uge (LLVM.xor e (const? (-124))) (LLVM.or e_1 (sub (const? 0) e_1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_const_slt_thm (e : IntW 8) :
  icmp IntPredicate.slt (LLVM.xor e (const? 123)) (LLVM.and (LLVM.xor e (const? 123)) (const? 7)) ⊑
    icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_const_sgt_thm (e : IntW 8) :
  icmp IntPredicate.sgt (LLVM.xor e (const? 123)) (LLVM.and (LLVM.xor e (const? 123)) (const? 7)) ⊑
    icmp IntPredicate.sgt (LLVM.xor e (const? 123)) (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_const_sle_thm (e : IntW 8) :
  icmp IntPredicate.sle (LLVM.and (LLVM.xor e (const? 123)) (const? 31)) (LLVM.xor e (const? 123)) ⊑
    icmp IntPredicate.sgt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_is_mask_const_sge_thm (e : IntW 8) :
  icmp IntPredicate.sge (LLVM.and (LLVM.xor e (const? 123)) (const? 31)) (LLVM.xor e (const? 123)) ⊑
    icmp IntPredicate.slt (LLVM.xor e (const? 123)) (const? 32) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_x_and_nmask_eq_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.eq (select e_2 (shl (const? (-1)) e_1) (const? 0))
      (LLVM.and e (select e_2 (shl (const? (-1)) e_1) (const? 0))) ⊑
    select (LLVM.xor e_2 (const? 1)) (const? 1)
      (icmp IntPredicate.ule (shl (const? (-1)) e_1 { «nsw» := true, «nuw» := false }) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_x_and_nmask_ne_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and e_2 (select e_1 (shl (const? (-1)) e) (const? 0)))
      (select e_1 (shl (const? (-1)) e) (const? 0)) ⊑
    select e_1 (icmp IntPredicate.ugt (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) e_2) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_x_and_nmask_ult_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.ult (LLVM.and e_2 (select e_1 (shl (const? (-1)) e) (const? 0)))
      (select e_1 (shl (const? (-1)) e) (const? 0)) ⊑
    select e_1 (icmp IntPredicate.ugt (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) e_2) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_x_and_nmask_uge_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.uge (LLVM.and e_2 (select e_1 (shl (const? (-1)) e) (const? 0)))
      (select e_1 (shl (const? (-1)) e) (const? 0)) ⊑
    select (LLVM.xor e_1 (const? 1)) (const? 1)
      (icmp IntPredicate.ule (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_x_and_nmask_slt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (LLVM.and e_1 (shl (const? (-1)) e)) (shl (const? (-1)) e) ⊑
    icmp IntPredicate.sgt (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_x_and_nmask_sge_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sge (LLVM.and e_1 (shl (const? (-1)) e)) (shl (const? (-1)) e) ⊑
    icmp IntPredicate.sle (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_x_and_nmask_slt_fail_maybe_z_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.slt (LLVM.and e_2 (select e_1 (shl (const? (-1)) e) (const? 0)))
      (select e_1 (shl (const? (-1)) e) (const? 0)) ⊑
    icmp IntPredicate.slt (LLVM.and e_2 (select e_1 (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) (const? 0)))
      (select e_1 (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_x_and_nmask_sge_fail_maybe_z_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.sge (LLVM.and e_2 (select e_1 (shl (const? (-1)) e) (const? 0)))
      (select e_1 (shl (const? (-1)) e) (const? 0)) ⊑
    icmp IntPredicate.sge (LLVM.and e_2 (select e_1 (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) (const? 0)))
      (select e_1 (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_x_or_mask_ne_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.ne (LLVM.or (select e_2 (lshr (const? (-1)) e_1) (const? 0)) (LLVM.xor e (const? (-1))))
      (const? (-1)) ⊑
    icmp IntPredicate.ugt e (select e_2 (lshr (const? (-1)) e_1) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


