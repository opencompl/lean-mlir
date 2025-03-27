
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsaturatinghaddhsub_proof
theorem test_simplify_decrement_invalid_ne_thm (e : IntW 8) :
  select (icmp IntPredicate.ne e (const? 8 0)) (const? 8 0) (sub e (const? 8 1)) ⊑
    sext 8 (icmp IntPredicate.eq e (const? 8 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_invalid_simplify_sub2_thm (e : IntW 8) :
  select (icmp IntPredicate.eq e (const? 8 0)) (const? 8 0) (sub e (const? 8 2)) ⊑
    select (icmp IntPredicate.eq e (const? 8 0)) (const? 8 0) (add e (const? 8 (-2))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_invalid_simplify_eq2_thm (e : IntW 8) :
  select (icmp IntPredicate.eq e (const? 8 2)) (const? 8 0) (sub e (const? 8 1)) ⊑
    select (icmp IntPredicate.eq e (const? 8 2)) (const? 8 0) (add e (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_invalid_simplify_select_1_thm (e : IntW 8) :
  select (icmp IntPredicate.eq e (const? 8 0)) (const? 8 1) (sub e (const? 8 1)) ⊑
    select (icmp IntPredicate.eq e (const? 8 0)) (const? 8 1) (add e (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_invalid_simplify_other_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 0)) (const? 8 0) (sub e (const? 8 1)) ⊑
    select (icmp IntPredicate.eq e_1 (const? 8 0)) (const? 8 0) (add e (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uadd_sat_flipped_wrong_bounds_thm (e : IntW 32) :
  select (icmp IntPredicate.uge e (const? 32 (-12))) (const? 32 (-1)) (add e (const? 32 9)) ⊑
    select (icmp IntPredicate.ugt e (const? 32 (-13))) (const? 32 (-1)) (add e (const? 32 9)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uadd_sat_flipped_wrong_bounds4_thm (e : IntW 32) :
  select (icmp IntPredicate.uge e (const? 32 (-8))) (const? 32 (-1)) (add e (const? 32 9)) ⊑
    select (icmp IntPredicate.ugt e (const? 32 (-9))) (const? 32 (-1)) (add e (const? 32 9)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uadd_sat_flipped_wrong_bounds6_thm (e : IntW 32) :
  select (icmp IntPredicate.ule e (const? 32 (-12))) (add e (const? 32 9)) (const? 32 (-1)) ⊑
    select (icmp IntPredicate.ult e (const? 32 (-11))) (add e (const? 32 9)) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uadd_sat_flipped_wrong_bounds7_thm (e : IntW 32) :
  select (icmp IntPredicate.ule e (const? 32 (-12))) (add e (const? 32 9)) (const? 32 (-1)) ⊑
    select (icmp IntPredicate.ult e (const? 32 (-11))) (add e (const? 32 9)) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uadd_sat_canon_nuw_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult (add e_1 e { «nsw» := false, «nuw» := true }) e_1) (const? 32 (-1))
      (add e_1 e { «nsw» := false, «nuw» := true }) ⊑
    add e_1 e { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uadd_sat_canon_y_nuw_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult (add e_1 e { «nsw» := false, «nuw» := true }) e) (const? 32 (-1))
      (add e_1 e { «nsw» := false, «nuw» := true }) ⊑
    add e_1 e { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uadd_sat_via_add_nonstrict_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ule (add e_1 e) e) (const? 32 (-1)) (add e_1 e) ⊑
    select (icmp IntPredicate.ugt (add e_1 e) e) (add e_1 e) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uadd_sat_via_add_swapped_cmp_nonstrict_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.uge e_1 (add e e_1)) (const? 32 (-1)) (add e e_1) ⊑
    select (icmp IntPredicate.ult e_1 (add e e_1)) (add e e_1) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
