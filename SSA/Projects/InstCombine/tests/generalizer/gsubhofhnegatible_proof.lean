
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsubhofhnegatible_proof
theorem t0_proof.t0_thm_1 (e : IntW 8) : sub e (const? 8 (-42)) ⊑ add e (const? 8 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_proof.t2_thm_1 (e e_1 : IntW 8) :
  sub e (shl (const? 8 (-42)) e_1) ⊑ add (shl (const? 8 42) e_1) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t4_proof.t4_thm_1 (e : IntW 8) (e_1 : IntW 1) :
  sub e (select e_1 (const? 8 (-42)) (const? 8 44)) ⊑ add (select e_1 (const? 8 42) (const? 8 (-44))) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR52261_proof.PR52261_thm_1 (e : IntW 1) :
  LLVM.and (select e (const? 32 2) (const? 32 (-2)))
      (sub (const? 32 0) (select e (const? 32 2) (const? 32 (-2))) { «nsw» := true }) ⊑
    const? 32 2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t7_proof.t7_thm_1 (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  sub e (select e_1 (const? 8 0) (shl (const? 8 1) e_2)) ⊑
    add (select e_1 (const? 8 0) (shl (const? 8 (-1)) e_2 { «nsw» := true })) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t9_proof.t9_thm_1 (e e_1 : IntW 8) : sub (const? 8 0) (sub e_1 e) ⊑ sub e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem neg_of_sub_from_constant_proof.neg_of_sub_from_constant_thm_1 (e : IntW 8) :
  sub (const? 8 0) (sub (const? 8 42) e) ⊑ add e (const? 8 (-42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_from_constant_of_sub_from_constant_proof.sub_from_constant_of_sub_from_constant_thm_1 (e : IntW 8) :
  sub (const? 8 11) (sub (const? 8 42) e) ⊑ add e (const? 8 (-31)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_from_variable_of_sub_from_constant_proof.sub_from_variable_of_sub_from_constant_thm_1 (e e_1 : IntW 8) :
  sub e_1 (sub (const? 8 42) e) ⊑ add (add e (const? 8 (-42))) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem neg_of_add_with_constant_proof.neg_of_add_with_constant_thm_1 (e : IntW 8) :
  sub (const? 8 0) (add e (const? 8 42)) ⊑ sub (const? 8 (-42)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_from_constant_of_add_with_constant_proof.sub_from_constant_of_add_with_constant_thm_1 (e : IntW 8) :
  sub (const? 8 11) (add e (const? 8 42)) ⊑ sub (const? 8 (-31)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t20_proof.t20_thm_1 (e : IntW 8) (e_1 : IntW 16) :
  sub e (trunc 8 (shl (const? 16 (-42)) e_1)) ⊑ add e (trunc 8 (shl (const? 16 42) e_1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_xor_proof.negate_xor_thm_1 (e : IntW 4) :
  sub (const? 4 0) (LLVM.xor e (const? 4 5)) ⊑ add (LLVM.xor e (const? 4 (-6))) (const? 4 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_shl_xor_proof.negate_shl_xor_thm_1 (e e_1 : IntW 4) :
  sub (const? 4 0) (shl (LLVM.xor e (const? 4 5)) e_1) ⊑
    shl (add (LLVM.xor e (const? 4 (-6))) (const? 4 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_sdiv_proof.negate_sdiv_thm_1 (e e_1 : IntW 8) :
  sub e (LLVM.sdiv e_1 (const? 8 42)) ⊑ add (LLVM.sdiv e_1 (const? 8 (-42))) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_ashr_proof.negate_ashr_thm_1 (e e_1 : IntW 8) :
  sub e (ashr e_1 (const? 8 7)) ⊑ add (lshr e_1 (const? 8 7)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_lshr_proof.negate_lshr_thm_1 (e e_1 : IntW 8) :
  sub e (lshr e_1 (const? 8 7)) ⊑ add (ashr e_1 (const? 8 7)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_sext_proof.negate_sext_thm_1 (e : IntW 8) (e_1 : IntW 1) : sub e (sext 8 e_1) ⊑ add e (zext 8 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_zext_proof.negate_zext_thm_1 (e : IntW 8) (e_1 : IntW 1) : sub e (zext 8 e_1) ⊑ add e (sext 8 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negation_of_increment_via_or_with_no_common_bits_set_proof.negation_of_increment_via_or_with_no_common_bits_set_thm_1 (e e_1 : IntW 8) :
  sub e (LLVM.or (shl e_1 (const? 8 1)) (const? 8 1)) ⊑ add e (LLVM.xor (shl e_1 (const? 8 1)) (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negation_of_increment_via_or_disjoint_proof.negation_of_increment_via_or_disjoint_thm_1 (e e_1 : IntW 8) :
  sub e (LLVM.or e_1 (const? 8 1) { «disjoint» := true }) ⊑ add e (LLVM.xor e_1 (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_add_with_single_negatible_operand_proof.negate_add_with_single_negatible_operand_thm_1 (e : IntW 8) :
  sub (const? 8 0) (add e (const? 8 42)) ⊑ sub (const? 8 (-42)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_add_with_single_negatible_operand_depth2_proof.negate_add_with_single_negatible_operand_depth2_thm_1 (e e_1 : IntW 8) :
  sub (const? 8 0) (mul (add e (const? 8 21)) e_1) ⊑ mul (sub (const? 8 (-21)) e) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_select_of_op_vs_negated_op_nsw_proof.negate_select_of_op_vs_negated_op_nsw_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  sub e_1 (select e_2 (sub (const? 8 0) e { «nsw» := true }) e) ⊑ add (select e_2 e (sub (const? 8 0) e)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_select_of_op_vs_negated_op_nsw_commuted_proof.negate_select_of_op_vs_negated_op_nsw_commuted_thm_1 (e e_1 : IntW 8) (e_2 : IntW 1) :
  sub e_1 (select e_2 e (sub (const? 8 0) e { «nsw» := true })) ⊑ add (select e_2 (sub (const? 8 0) e) e) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negate_select_of_op_vs_negated_op_nsw_xyyx_proof.negate_select_of_op_vs_negated_op_nsw_xyyx_thm_1 (e e_1 e_2 : IntW 8) (e_3 : IntW 1) :
  sub e_2 (select e_3 (sub e e_1 { «nsw» := true }) (sub e_1 e { «nsw» := true })) ⊑
    add (select e_3 (sub e_1 e) (sub e e_1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
