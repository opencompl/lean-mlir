
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsaturatinghaddhsub_proof
theorem test_simplify_decrement_invalid_ne_proof.test_simplify_decrement_invalid_ne_thm_1 (e : IntW 8) :
  select (icmp IntPred.ne e (const? 8 0)) (const? 8 0) (sub e (const? 8 1)) ⊑
    sext 8 (icmp IntPred.eq e (const? 8 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_invalid_simplify_sub2_proof.test_invalid_simplify_sub2_thm_1 (e : IntW 8) :
  select (icmp IntPred.eq e (const? 8 0)) (const? 8 0) (sub e (const? 8 2)) ⊑
    select (icmp IntPred.eq e (const? 8 0)) (const? 8 0) (add e (const? 8 (-2))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_invalid_simplify_eq2_proof.test_invalid_simplify_eq2_thm_1 (e : IntW 8) :
  select (icmp IntPred.eq e (const? 8 2)) (const? 8 0) (sub e (const? 8 1)) ⊑
    select (icmp IntPred.eq e (const? 8 2)) (const? 8 0) (add e (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_invalid_simplify_select_1_proof.test_invalid_simplify_select_1_thm_1 (e : IntW 8) :
  select (icmp IntPred.eq e (const? 8 0)) (const? 8 1) (sub e (const? 8 1)) ⊑
    select (icmp IntPred.eq e (const? 8 0)) (const? 8 1) (add e (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_invalid_simplify_other_proof.test_invalid_simplify_other_thm_1 (e e_1 : IntW 8) :
  select (icmp IntPred.eq e (const? 8 0)) (const? 8 0) (sub e_1 (const? 8 1)) ⊑
    select (icmp IntPred.eq e (const? 8 0)) (const? 8 0) (add e_1 (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uadd_sat_flipped_wrong_bounds_proof.uadd_sat_flipped_wrong_bounds_thm_1 (e : IntW 32) :
  select (icmp IntPred.uge e (const? 32 (-12))) (const? 32 (-1)) (add e (const? 32 9)) ⊑
    select (icmp IntPred.ugt e (const? 32 (-13))) (const? 32 (-1)) (add e (const? 32 9)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uadd_sat_flipped_wrong_bounds4_proof.uadd_sat_flipped_wrong_bounds4_thm_1 (e : IntW 32) :
  select (icmp IntPred.uge e (const? 32 (-8))) (const? 32 (-1)) (add e (const? 32 9)) ⊑
    select (icmp IntPred.ugt e (const? 32 (-9))) (const? 32 (-1)) (add e (const? 32 9)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uadd_sat_flipped_wrong_bounds6_proof.uadd_sat_flipped_wrong_bounds6_thm_1 (e : IntW 32) :
  select (icmp IntPred.ule e (const? 32 (-12))) (add e (const? 32 9)) (const? 32 (-1)) ⊑
    select (icmp IntPred.ult e (const? 32 (-11))) (add e (const? 32 9)) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uadd_sat_flipped_wrong_bounds7_proof.uadd_sat_flipped_wrong_bounds7_thm_1 (e : IntW 32) :
  select (icmp IntPred.ule e (const? 32 (-12))) (add e (const? 32 9)) (const? 32 (-1)) ⊑
    select (icmp IntPred.ult e (const? 32 (-11))) (add e (const? 32 9)) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uadd_sat_canon_nuw_proof.uadd_sat_canon_nuw_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ult (add e e_1 { «nuw» := true }) e) (const? 32 (-1)) (add e e_1 { «nuw» := true }) ⊑
    add e e_1 { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uadd_sat_canon_y_nuw_proof.uadd_sat_canon_y_nuw_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ult (add e e_1 { «nuw» := true }) e_1) (const? 32 (-1)) (add e e_1 { «nuw» := true }) ⊑
    add e e_1 { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uadd_sat_via_add_nonstrict_proof.uadd_sat_via_add_nonstrict_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ule (add e e_1) e_1) (const? 32 (-1)) (add e e_1) ⊑
    select (icmp IntPred.ugt (add e e_1) e_1) (add e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uadd_sat_via_add_swapped_cmp_nonstrict_proof.uadd_sat_via_add_swapped_cmp_nonstrict_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.uge e_1 (add e e_1)) (const? 32 (-1)) (add e e_1) ⊑
    select (icmp IntPred.ult e_1 (add e e_1)) (add e e_1) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
