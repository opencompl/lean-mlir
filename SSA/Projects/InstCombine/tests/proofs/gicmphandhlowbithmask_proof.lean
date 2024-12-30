
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gicmphandhlowbithmask_proof
theorem src_is_mask_zext_thm (e : IntW 8) (e_1 : IntW 16) :
  icmp IntPredicate.eq (LLVM.and (LLVM.xor e_1 (const? 16 123)) (zext 16 (lshr (const? 8 (-1)) e)))
      (LLVM.xor e_1 (const? 16 123)) ⊑
    icmp IntPredicate.ule (LLVM.xor e_1 (const? 16 123)) (zext 16 (lshr (const? 8 (-1)) e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_zext_fail_not_mask_thm (e : IntW 8) (e_1 : IntW 16) :
  icmp IntPredicate.eq (LLVM.and (LLVM.xor e_1 (const? 16 123)) (zext 16 (lshr (const? 8 (-2)) e)))
      (LLVM.xor e_1 (const? 16 123)) ⊑
    icmp IntPredicate.eq (LLVM.or (LLVM.xor e_1 (const? 16 (-124))) (zext 16 (lshr (const? 8 (-2)) e)))
      (const? 16 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_sext_thm (e : IntW 16) (e_1 : IntW 8) :
  icmp IntPredicate.eq
      (LLVM.and (LLVM.xor (sext 16 (lshr (const? 8 31) e_1)) (const? 16 (-1))) (LLVM.xor e (const? 16 123)))
      (const? 16 0) ⊑
    icmp IntPredicate.ule (LLVM.xor e (const? 16 123)) (zext 16 (lshr (const? 8 31) e_1) { «nneg» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_and_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.eq (LLVM.xor e_2 (const? 8 123))
      (LLVM.and (LLVM.xor e_2 (const? 8 123)) (LLVM.and (ashr (const? 8 7) e_1) (lshr (const? 8 (-1)) e))) ⊑
    icmp IntPredicate.ule (LLVM.xor e_2 (const? 8 123))
      (LLVM.and (lshr (const? 8 7) e_1) (lshr (const? 8 (-1)) e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_and_fail_mixed_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.eq (LLVM.xor e_2 (const? 8 123))
      (LLVM.and (LLVM.xor e_2 (const? 8 123)) (LLVM.and (ashr (const? 8 (-8)) e_1) (lshr (const? 8 (-1)) e))) ⊑
    icmp IntPredicate.eq
      (LLVM.or (LLVM.and (ashr (const? 8 (-8)) e_1) (lshr (const? 8 (-1)) e)) (LLVM.xor e_2 (const? 8 (-124))))
      (const? 8 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_or_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.xor e_1 (const? 8 123))
      (LLVM.and (LLVM.and (lshr (const? 8 (-1)) e) (const? 8 7)) (LLVM.xor e_1 (const? 8 123))) ⊑
    icmp IntPredicate.ule (LLVM.xor e_1 (const? 8 123)) (LLVM.and (lshr (const? 8 (-1)) e) (const? 8 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_xor_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor e_1 (const? 8 123)) (LLVM.xor e (add e (const? 8 (-1)))))
      (LLVM.xor e_1 (const? 8 123)) ⊑
    icmp IntPredicate.ugt (LLVM.xor e_1 (const? 8 123)) (LLVM.xor e (add e (const? 8 (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_xor_fail_notmask_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne
      (LLVM.and (LLVM.xor e_1 (const? 8 123)) (LLVM.xor (LLVM.xor e (add e (const? 8 (-1)))) (const? 8 (-1))))
      (LLVM.xor e_1 (const? 8 123)) ⊑
    icmp IntPredicate.ne (LLVM.or (LLVM.xor e (sub (const? 8 0) e)) (LLVM.xor e_1 (const? 8 (-124))))
      (const? 8 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_select_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.ne
      (LLVM.and (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) (LLVM.xor e (const? 8 123)))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPredicate.ugt (LLVM.xor e (const? 8 123))
      (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_shl_lshr_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (const? 8 0)
      (LLVM.and (LLVM.xor e_1 (const? 8 123)) (LLVM.xor (lshr (shl (const? 8 (-1)) e) e) (const? 8 (-1)))) ⊑
    icmp IntPredicate.ugt (LLVM.xor e_1 (const? 8 122)) (lshr (const? 8 (-1)) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_shl_lshr_fail_not_allones_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (const? 8 0)
      (LLVM.and (LLVM.xor e_1 (const? 8 123)) (LLVM.xor (lshr (shl (const? 8 (-2)) e) e) (const? 8 (-1)))) ⊑
    icmp IntPredicate.ne (LLVM.or (LLVM.xor e_1 (const? 8 (-124))) (LLVM.and (lshr (const? 8 (-1)) e) (const? 8 (-2))))
      (const? 8 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_lshr_thm (e e_1 : IntW 8) (e_2 : IntW 1) (e_3 : IntW 8) :
  icmp IntPredicate.ne (LLVM.xor e_3 (const? 8 123))
      (LLVM.and (lshr (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) e)
        (LLVM.xor e_3 (const? 8 123))) ⊑
    icmp IntPredicate.ugt (LLVM.xor e_3 (const? 8 123))
      (lshr (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_ashr_thm (e e_1 : IntW 8) (e_2 : IntW 1) (e_3 : IntW 8) :
  icmp IntPredicate.ult
      (LLVM.and (LLVM.xor e_3 (const? 8 123))
        (ashr (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) e))
      (LLVM.xor e_3 (const? 8 123)) ⊑
    icmp IntPredicate.ugt (LLVM.xor e_3 (const? 8 123))
      (ashr (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 15)) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_p2_m1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (LLVM.and (add (shl (const? 8 2) e_1) (const? 8 (-1))) (LLVM.xor e (const? 8 123)))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPredicate.ugt (LLVM.xor e (const? 8 123)) (add (shl (const? 8 2) e_1) (const? 8 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_notmask_sext_thm (e : IntW 8) (e_1 : IntW 16) :
  icmp IntPredicate.ule (LLVM.xor e_1 (const? 16 123))
      (LLVM.and (LLVM.xor (sext 16 (shl (const? 8 (-8)) e)) (const? 16 (-1))) (LLVM.xor e_1 (const? 16 123))) ⊑
    icmp IntPredicate.uge (LLVM.xor e_1 (const? 16 (-128))) (sext 16 (shl (const? 8 (-8)) e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_notmask_x_xor_neg_x_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.eq
      (LLVM.and (LLVM.xor e_2 (const? 8 123)) (select e_1 (LLVM.xor e (sub (const? 8 0) e)) (const? 8 (-8))))
      (const? 8 0) ⊑
    icmp IntPredicate.ule (LLVM.xor e_2 (const? 8 123))
      (select e_1 (LLVM.xor e (add e (const? 8 (-1)))) (const? 8 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_notmask_x_xor_neg_x_inv_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.eq
      (LLVM.and (select e_2 (LLVM.xor e_1 (sub (const? 8 0) e_1)) (const? 8 (-8))) (LLVM.xor e (const? 8 123)))
      (const? 8 0) ⊑
    icmp IntPredicate.ule (LLVM.xor e (const? 8 123))
      (select e_2 (LLVM.xor e_1 (add e_1 (const? 8 (-1)))) (const? 8 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_notmask_lshr_shl_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq
      (LLVM.and (LLVM.xor (shl (lshr (const? 8 (-1)) e_1) e_1) (const? 8 (-1))) (LLVM.xor e (const? 8 123)))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPredicate.uge (LLVM.xor e (const? 8 (-124)))
      (shl (const? 8 (-1)) e_1 { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_notmask_lshr_shl_fail_mismatch_shifts_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.eq
      (LLVM.and (LLVM.xor (shl (lshr (const? 8 (-1)) e_2) e_1) (const? 8 (-1))) (LLVM.xor e (const? 8 123)))
      (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPredicate.eq (LLVM.and (LLVM.xor e (const? 8 123)) (shl (lshr (const? 8 (-1)) e_2) e_1))
      (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_notmask_ashr_thm (e : IntW 16) (e_1 : IntW 8) (e_2 : IntW 16) :
  icmp IntPredicate.eq (LLVM.xor e_2 (const? 16 123))
      (LLVM.and (LLVM.xor e_2 (const? 16 123))
        (LLVM.xor (ashr (sext 16 (shl (const? 8 (-32)) e_1)) e) (const? 16 (-1)))) ⊑
    icmp IntPredicate.uge (LLVM.xor e_2 (const? 16 (-124))) (ashr (sext 16 (shl (const? 8 (-32)) e_1)) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_notmask_neg_p2_fail_not_invertable_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (const? 8 0)
      (LLVM.and (sub (const? 8 0) (LLVM.and (sub (const? 8 0) e_1) e_1)) (LLVM.xor e (const? 8 123))) ⊑
    icmp IntPredicate.uge (LLVM.xor e (const? 8 (-124))) (LLVM.or e_1 (sub (const? 8 0) e_1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_const_slt_thm (e : IntW 8) :
  icmp IntPredicate.slt (LLVM.xor e (const? 8 123)) (LLVM.and (LLVM.xor e (const? 8 123)) (const? 8 7)) ⊑
    icmp IntPredicate.slt e (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_const_sgt_thm (e : IntW 8) :
  icmp IntPredicate.sgt (LLVM.xor e (const? 8 123)) (LLVM.and (LLVM.xor e (const? 8 123)) (const? 8 7)) ⊑
    icmp IntPredicate.sgt (LLVM.xor e (const? 8 123)) (const? 8 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_const_sle_thm (e : IntW 8) :
  icmp IntPredicate.sle (LLVM.and (LLVM.xor e (const? 8 123)) (const? 8 31)) (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPredicate.sgt e (const? 8 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_is_mask_const_sge_thm (e : IntW 8) :
  icmp IntPredicate.sge (LLVM.and (LLVM.xor e (const? 8 123)) (const? 8 31)) (LLVM.xor e (const? 8 123)) ⊑
    icmp IntPredicate.slt (LLVM.xor e (const? 8 123)) (const? 8 32) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_x_and_nmask_eq_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.eq (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0))
      (LLVM.and e (select e_2 (shl (const? 8 (-1)) e_1) (const? 8 0))) ⊑
    select (LLVM.xor e_2 (const? 1 1)) (const? 1 1)
      (icmp IntPredicate.ule (shl (const? 8 (-1)) e_1 { «nsw» := true, «nuw» := false }) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_x_and_nmask_ne_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and e_2 (select e_1 (shl (const? 8 (-1)) e) (const? 8 0)))
      (select e_1 (shl (const? 8 (-1)) e) (const? 8 0)) ⊑
    select e_1 (icmp IntPredicate.ugt (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) e_2)
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_x_and_nmask_ult_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.ult (LLVM.and e_2 (select e_1 (shl (const? 8 (-1)) e) (const? 8 0)))
      (select e_1 (shl (const? 8 (-1)) e) (const? 8 0)) ⊑
    select e_1 (icmp IntPredicate.ugt (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) e_2)
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_x_and_nmask_uge_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.uge (LLVM.and e_2 (select e_1 (shl (const? 8 (-1)) e) (const? 8 0)))
      (select e_1 (shl (const? 8 (-1)) e) (const? 8 0)) ⊑
    select (LLVM.xor e_1 (const? 1 1)) (const? 1 1)
      (icmp IntPredicate.ule (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_x_and_nmask_slt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (LLVM.and e_1 (shl (const? 8 (-1)) e)) (shl (const? 8 (-1)) e) ⊑
    icmp IntPredicate.sgt (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_x_and_nmask_sge_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sge (LLVM.and e_1 (shl (const? 8 (-1)) e)) (shl (const? 8 (-1)) e) ⊑
    icmp IntPredicate.sle (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_x_and_nmask_slt_fail_maybe_z_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.slt (LLVM.and e_2 (select e_1 (shl (const? 8 (-1)) e) (const? 8 0)))
      (select e_1 (shl (const? 8 (-1)) e) (const? 8 0)) ⊑
    icmp IntPredicate.slt
      (LLVM.and e_2 (select e_1 (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) (const? 8 0)))
      (select e_1 (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) (const? 8 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_x_and_nmask_sge_fail_maybe_z_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  icmp IntPredicate.sge (LLVM.and e_2 (select e_1 (shl (const? 8 (-1)) e) (const? 8 0)))
      (select e_1 (shl (const? 8 (-1)) e) (const? 8 0)) ⊑
    icmp IntPredicate.sge
      (LLVM.and e_2 (select e_1 (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) (const? 8 0)))
      (select e_1 (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) (const? 8 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src_x_or_mask_ne_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.ne (LLVM.or (select e_2 (lshr (const? 8 (-1)) e_1) (const? 8 0)) (LLVM.xor e (const? 8 (-1))))
      (const? 8 (-1)) ⊑
    icmp IntPredicate.ugt e (select e_2 (lshr (const? 8 (-1)) e_1) (const? 8 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


