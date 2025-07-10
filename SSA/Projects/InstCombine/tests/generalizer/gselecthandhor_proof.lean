
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthandhor_proof
theorem logical_and_not_proof.logical_and_not_thm_1 (e e_1 : IntW 1) :
  select e (const? 1 0) e_1 ⊑ select (LLVM.xor e (const? 1 1)) e_1 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logical_or_not_proof.logical_or_not_thm_1 (e e_1 : IntW 1) :
  select e e_1 (const? 1 1) ⊑ select (LLVM.xor e (const? 1 1)) (const? 1 1) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logical_and_cond_reuse_proof.logical_and_cond_reuse_thm_1 (e e_1 : IntW 1) :
  select e e_1 e ⊑ select e e_1 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logical_or_cond_reuse_proof.logical_or_cond_reuse_thm_1 (e e_1 : IntW 1) : select e e e_1 ⊑ select e (const? 1 1) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logical_and_not_cond_reuse_proof.logical_and_not_cond_reuse_thm_1 (e e_1 : IntW 1) :
  select e e_1 (LLVM.xor e (const? 1 1)) ⊑ select (LLVM.xor e (const? 1 1)) (const? 1 1) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logical_or_not_cond_reuse_proof.logical_or_not_cond_reuse_thm_1 (e e_1 : IntW 1) :
  select e (LLVM.xor e (const? 1 1)) e_1 ⊑ select (LLVM.xor e (const? 1 1)) e_1 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logical_or_implies_proof.logical_or_implies_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (const? 1 1) (icmp IntPred.eq e (const? 32 42)) ⊑
    LLVM.or (icmp IntPred.eq e (const? 32 0)) (icmp IntPred.eq e (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logical_or_implies_folds_proof.logical_or_implies_folds_thm_1 (e : IntW 32) :
  select (icmp IntPred.slt e (const? 32 0)) (const? 1 1) (icmp IntPred.sge e (const? 32 0)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logical_and_implies_proof.logical_and_implies_thm_1 (e : IntW 32) :
  select (icmp IntPred.ne e (const? 32 0)) (icmp IntPred.ne e (const? 32 42)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.ne e (const? 32 0)) (icmp IntPred.ne e (const? 32 42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logical_and_implies_folds_proof.logical_and_implies_folds_thm_1 (e : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 42)) (icmp IntPred.ne e (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.ugt e (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_not_true_proof.not_not_true_thm_1 (e e_1 : IntW 1) :
  select (LLVM.xor e (const? 1 1)) (LLVM.xor e_1 (const? 1 1)) (const? 1 1) ⊑
    select e (const? 1 1) (LLVM.xor e_1 (const? 1 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_not_false_proof.not_not_false_thm_1 (e e_1 : IntW 1) :
  select (LLVM.xor e (const? 1 1)) (LLVM.xor e_1 (const? 1 1)) (const? 1 0) ⊑
    LLVM.xor (select e (const? 1 1) e_1) (const? 1 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_true_not_proof.not_true_not_thm_1 (e e_1 : IntW 1) :
  select (LLVM.xor e (const? 1 1)) (const? 1 1) (LLVM.xor e_1 (const? 1 1)) ⊑
    LLVM.xor (select e e_1 (const? 1 0)) (const? 1 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_false_not_proof.not_false_not_thm_1 (e e_1 : IntW 1) :
  select (LLVM.xor e (const? 1 1)) (const? 1 0) (LLVM.xor e_1 (const? 1 1)) ⊑
    select e (LLVM.xor e_1 (const? 1 1)) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_or1_proof.and_or1_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.or (LLVM.xor e (const? 1 1)) e_2) e e_1 ⊑ select e (select e_2 (const? 1 1) e_1) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_or2_proof.and_or2_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.and (LLVM.xor e_2 (const? 1 1)) e_1) e e_1 ⊑ select e_1 (select e_2 (const? 1 1) e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_or1_commuted_proof.and_or1_commuted_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 (LLVM.xor e (const? 1 1))) e e_1 ⊑ select e (select e_2 (const? 1 1) e_1) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_or2_commuted_proof.and_or2_commuted_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_1 (LLVM.xor e_2 (const? 1 1))) e e_1 ⊑ select e_1 (select e_2 (const? 1 1) e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_or1_wrong_operand_proof.and_or1_wrong_operand_thm_1 (e e_1 e_2 e_3 : IntW 1) :
  select (LLVM.or (LLVM.xor e (const? 1 1)) e_2) e_3 e_1 ⊑
    select (LLVM.or e_2 (LLVM.xor e (const? 1 1))) e_3 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_or2_wrong_operand_proof.and_or2_wrong_operand_thm_1 (e e_1 e_2 e_3 : IntW 1) :
  select (LLVM.and (LLVM.xor e_2 (const? 1 1)) e_1) e e_3 ⊑
    select (LLVM.and e_1 (LLVM.xor e_2 (const? 1 1))) e e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_or3_proof.and_or3_thm_1 (e e_1 : IntW 1) (e_2 e_3 : IntW 32) :
  select (LLVM.and e_1 (icmp IntPred.eq e_2 e_3)) e e_1 ⊑
    select e_1 (select (icmp IntPred.ne e_2 e_3) (const? 1 1) e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_or3_commuted_proof.and_or3_commuted_thm_1 (e e_1 : IntW 1) (e_2 e_3 : IntW 32) :
  select (LLVM.and (icmp IntPred.eq e_2 e_3) e_1) e e_1 ⊑
    select e_1 (select (icmp IntPred.ne e_2 e_3) (const? 1 1) e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and1_proof.or_and1_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.and (LLVM.xor e_1 (const? 1 1)) e_2) e e_1 ⊑ select e_1 (const? 1 1) (select e_2 e (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and2_proof.or_and2_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.or (LLVM.xor e_2 (const? 1 1)) e) e e_1 ⊑ select e (const? 1 1) (select e_2 e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and1_commuted_proof.or_and1_commuted_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 (LLVM.xor e_1 (const? 1 1))) e e_1 ⊑ select e_1 (const? 1 1) (select e_2 e (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and2_commuted_proof.or_and2_commuted_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.or e (LLVM.xor e_2 (const? 1 1))) e e_1 ⊑ select e (const? 1 1) (select e_2 e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem pr64558_proof.pr64558_thm_1 (e e_1 : IntW 1) :
  select (LLVM.and (LLVM.xor e_1 (const? 1 1)) e) e e_1 ⊑ LLVM.or e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and3_proof.or_and3_thm_1 (e e_1 : IntW 1) (e_2 e_3 : IntW 32) :
  select (LLVM.or e (icmp IntPred.eq e_2 e_3)) e e_1 ⊑
    select e (const? 1 1) (select (icmp IntPred.ne e_2 e_3) e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and3_commuted_proof.or_and3_commuted_thm_1 (e e_1 : IntW 1) (e_2 e_3 : IntW 32) :
  select (LLVM.or (icmp IntPred.eq e_2 e_3) e) e e_1 ⊑
    select e (const? 1 1) (select (icmp IntPred.ne e_2 e_3) e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or_eq_a_b_proof.test_or_eq_a_b_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  select (LLVM.or e (icmp IntPred.eq e_1 e_2)) e_1 e_2 ⊑ select e e_1 e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_and_ne_a_b_proof.test_and_ne_a_b_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  select (LLVM.and e (icmp IntPred.ne e_1 e_2)) e_1 e_2 ⊑ select e e_1 e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or_eq_a_b_commuted_proof.test_or_eq_a_b_commuted_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  select (LLVM.or e (icmp IntPred.eq e_1 e_2)) e_2 e_1 ⊑ select e e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_and_ne_a_b_commuted_proof.test_and_ne_a_b_commuted_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  select (LLVM.and e (icmp IntPred.ne e_1 e_2)) e_2 e_1 ⊑ select e e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or_eq_different_operands_proof.test_or_eq_different_operands_thm_1 (e e_1 e_2 : IntW 8) :
  select (LLVM.or (icmp IntPred.eq e e_2) (icmp IntPred.eq e_1 e)) e e_1 ⊑ select (icmp IntPred.eq e e_2) e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or_ne_a_b_proof.test_or_ne_a_b_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  select (LLVM.or e (icmp IntPred.ne e_1 e_2)) e_1 e_2 ⊑ e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_logical_or_eq_a_b_proof.test_logical_or_eq_a_b_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  select (select e (const? 1 1) (icmp IntPred.eq e_1 e_2)) e_1 e_2 ⊑ select e e_1 e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_logical_and_ne_a_b_proof.test_logical_and_ne_a_b_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  select (select e (icmp IntPred.ne e_1 e_2) (const? 1 0)) e_1 e_2 ⊑ select e e_1 e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
