
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphlogical_proof
theorem masked_and_notallzeroes_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 39)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_and_notallzeroes_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 39)) (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_or_allzeroes_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 39)) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_or_allzeroes_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 39)) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_and_notallones_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7))
      (icmp IntPred.ne (LLVM.and e (const? 32 39)) (const? 32 39)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_and_notallones_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7))
      (icmp IntPred.ne (LLVM.and e (const? 32 39)) (const? 32 39)) (const? 1 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_or_allones_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7))
      (icmp IntPred.eq (LLVM.and e (const? 32 39)) (const? 32 39)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_or_allones_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 39)) (const? 32 39)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_and_notA_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 14)) e) (icmp IntPred.ne (LLVM.and e (const? 32 78)) e) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 (-79))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_and_notA_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 14)) e) (icmp IntPred.ne (LLVM.and e (const? 32 78)) e)
      (const? 1 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 (-79))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_and_notA_slightly_optimized_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.uge e (const? 32 8)) (icmp IntPred.ne (LLVM.and e (const? 32 39)) e) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 (-40))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_and_notA_slightly_optimized_logical_thm (e : IntW 32) :
  select (icmp IntPred.uge e (const? 32 8)) (icmp IntPred.ne (LLVM.and e (const? 32 39)) e) (const? 1 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 (-40))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_or_A_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 14)) e) (icmp IntPred.eq (LLVM.and e (const? 32 78)) e) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 (-79))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_or_A_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 14)) e) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 78)) e) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 (-79))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_or_A_slightly_optimized_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ult e (const? 32 8)) (icmp IntPred.eq (LLVM.and e (const? 32 39)) e) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 (-40))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_or_A_slightly_optimized_logical_thm (e : IntW 32) :
  select (icmp IntPred.ult e (const? 32 8)) (const? 1 1) (icmp IntPred.eq (LLVM.and e (const? 32 39)) e) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 (-40))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_or_allzeroes_notoptimised_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 39)) (const? 32 0)) ⊑
    LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 39)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem nomask_lhs_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq e (const? 32 0)) (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem nomask_lhs_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem nomask_rhs_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (icmp IntPred.eq e (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem nomask_rhs_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.eq e (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem fold_mask_cmps_to_false_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.eq e (const? 32 2147483647))
      (icmp IntPred.eq (LLVM.and e (const? 32 2147483647)) (const? 32 0)) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem fold_mask_cmps_to_false_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq e (const? 32 2147483647))
      (icmp IntPred.eq (LLVM.and e (const? 32 2147483647)) (const? 32 0)) (const? 1 0) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem fold_mask_cmps_to_true_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ne e (const? 32 2147483647))
      (icmp IntPred.ne (LLVM.and e (const? 32 2147483647)) (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem fold_mask_cmps_to_true_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne e (const? 32 2147483647)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 2147483647)) (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem cmpeq_bitwise_thm (e e_1 e_2 e_3 : IntW 8) :
  icmp IntPred.eq (LLVM.or (LLVM.xor e_3 e_2) (LLVM.xor e_1 e)) (const? 8 0) ⊑
    LLVM.and (icmp IntPred.eq e_3 e_2) (icmp IntPred.eq e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_0_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 1)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_1_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 1)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_1_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 1)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 14)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 1)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 14)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_2_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0)) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_2_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0)) (const? 1 0) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_3_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_3_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 0)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_4_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 255)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_4_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 255)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_5_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_5_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_6_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_6_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_7_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_7_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8)) (const? 1 0) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_7b_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 6)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 6)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8)) (const? 1 0) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 1)) ⊑
    LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_1_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 1)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 1)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 14)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 1)) ⊑
    LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 14)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_2_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_3_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 0)) ⊑
    LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_4_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 255)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 255)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_5_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_6_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_7_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 6)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 6)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 1))
      (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 1))
      (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 1))
      (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 1))
      (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 1))
      (icmp IntPred.ne (LLVM.and e (const? 32 14)) (const? 32 0)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 1))
      (icmp IntPred.ne (LLVM.and e (const? 32 14)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 0)) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 0)) (const? 1 0) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.ne (LLVM.and e (const? 32 255)) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.ne (LLVM.and e (const? 32 255)) (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0)) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0)) (const? 1 0) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.ne (LLVM.and e (const? 32 6)) (const? 32 0)) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_thm (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.ne (LLVM.and e (const? 32 6)) (const? 32 0)) (const? 1 0) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 1)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0)) ⊑
    LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 1))
      (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 1))
      (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 1)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 1)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 14)) (const? 32 0)) ⊑
    LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 1))
      (icmp IntPred.eq (LLVM.and e (const? 32 14)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 0)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) ⊑
    LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.eq (LLVM.and e (const? 32 255)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 255)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8))
      (icmp IntPred.eq (LLVM.and e (const? 32 6)) (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_thm (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 8)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and e (const? 32 6)) (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_bmask_notmixed_or_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 3))
      (icmp IntPred.eq (LLVM.and e (const? 32 255)) (const? 32 243)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_bmask_notmixed_and_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 3))
      (icmp IntPred.ne (LLVM.and e (const? 32 255)) (const? 32 243)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 15)) (const? 32 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem masked_icmps_bmask_notmixed_and_expected_false_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 3)) (const? 32 15))
      (icmp IntPred.ne (LLVM.and e (const? 32 255)) (const? 32 242)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 255)) (const? 32 242) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
