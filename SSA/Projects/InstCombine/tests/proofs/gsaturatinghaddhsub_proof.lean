
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsaturatinghaddhsub_proof
theorem test_simplify_decrement_invalid_ne_thm (e : IntW 8) :
  select (icmp IntPredicate.ne e (const? 0)) (const? 0) (sub e (const? 1)) ⊑
    sext 8 (icmp IntPredicate.eq e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_invalid_simplify_sub2_thm (e : IntW 8) :
  select (icmp IntPredicate.eq e (const? 0)) (const? 0) (sub e (const? 2)) ⊑
    select (icmp IntPredicate.eq e (const? 0)) (const? 0) (add e (const? (-2))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_invalid_simplify_eq2_thm (e : IntW 8) :
  select (icmp IntPredicate.eq e (const? 2)) (const? 0) (sub e (const? 1)) ⊑
    select (icmp IntPredicate.eq e (const? 2)) (const? 0) (add e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_invalid_simplify_select_1_thm (e : IntW 8) :
  select (icmp IntPredicate.eq e (const? 0)) (const? 1) (sub e (const? 1)) ⊑
    select (icmp IntPredicate.eq e (const? 0)) (const? 1) (add e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_invalid_simplify_other_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 0)) (const? 0) (sub e (const? 1)) ⊑
    select (icmp IntPredicate.eq e_1 (const? 0)) (const? 0) (add e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem uadd_sat_flipped_wrong_bounds_thm (e : IntW 32) :
  select (icmp IntPredicate.uge e (const? (-12))) (const? (-1)) (add e (const? 9)) ⊑
    select (icmp IntPredicate.ugt e (const? (-13))) (const? (-1)) (add e (const? 9)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem uadd_sat_flipped_wrong_bounds4_thm (e : IntW 32) :
  select (icmp IntPredicate.uge e (const? (-8))) (const? (-1)) (add e (const? 9)) ⊑
    select (icmp IntPredicate.ugt e (const? (-9))) (const? (-1)) (add e (const? 9)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem uadd_sat_flipped_wrong_bounds6_thm (e : IntW 32) :
  select (icmp IntPredicate.ule e (const? (-12))) (add e (const? 9)) (const? (-1)) ⊑
    select (icmp IntPredicate.ult e (const? (-11))) (add e (const? 9)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem uadd_sat_flipped_wrong_bounds7_thm (e : IntW 32) :
  select (icmp IntPredicate.ule e (const? (-12))) (add e (const? 9)) (const? (-1)) ⊑
    select (icmp IntPredicate.ult e (const? (-11))) (add e (const? 9)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem uadd_sat_canon_nuw_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult (add e_1 e { «nsw» := false, «nuw» := true }) e_1) (const? (-1))
      (add e_1 e { «nsw» := false, «nuw» := true }) ⊑
    add e_1 e { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem uadd_sat_canon_y_nuw_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult (add e_1 e { «nsw» := false, «nuw» := true }) e) (const? (-1))
      (add e_1 e { «nsw» := false, «nuw» := true }) ⊑
    add e_1 e { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem uadd_sat_via_add_nonstrict_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ule (add e_1 e) e) (const? (-1)) (add e_1 e) ⊑
    select (icmp IntPredicate.ugt (add e_1 e) e) (add e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem uadd_sat_via_add_swapped_cmp_nonstrict_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.uge e_1 (add e e_1)) (const? (-1)) (add e e_1) ⊑
    select (icmp IntPredicate.ult e_1 (add e e_1)) (add e e_1) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


