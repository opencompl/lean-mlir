
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthandhor_proof
theorem logical_and_not_thm (e e_1 : IntW 1) :
  select e_1 (const? 1 0) e ⊑ select (LLVM.xor e_1 (const? 1 1)) e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_not_thm (e e_1 : IntW 1) :
  select e_1 e (const? 1 1) ⊑ select (LLVM.xor e_1 (const? 1 1)) (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_cond_reuse_thm (e e_1 : IntW 1) : select e_1 e e_1 ⊑ select e_1 e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_cond_reuse_thm (e e_1 : IntW 1) : select e_1 e_1 e ⊑ select e_1 (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_not_cond_reuse_thm (e e_1 : IntW 1) :
  select e_1 e (LLVM.xor e_1 (const? 1 1)) ⊑ select (LLVM.xor e_1 (const? 1 1)) (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_not_cond_reuse_thm (e e_1 : IntW 1) :
  select e_1 (LLVM.xor e_1 (const? 1 1)) e ⊑ select (LLVM.xor e_1 (const? 1 1)) e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_implies_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 32 0)) (const? 1 1) (icmp IntPredicate.eq e (const? 32 42)) ⊑
    LLVM.or (icmp IntPredicate.eq e (const? 32 0)) (icmp IntPredicate.eq e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_implies_folds_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 32 0)) (const? 1 1) (icmp IntPredicate.sge e (const? 32 0)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_implies_thm (e : IntW 32) :
  select (icmp IntPredicate.ne e (const? 32 0)) (icmp IntPredicate.ne e (const? 32 42)) (const? 1 0) ⊑
    LLVM.and (icmp IntPredicate.ne e (const? 32 0)) (icmp IntPredicate.ne e (const? 32 42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_implies_folds_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt e (const? 32 42)) (icmp IntPredicate.ne e (const? 32 0)) (const? 1 0) ⊑
    icmp IntPredicate.ugt e (const? 32 42) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_not_true_thm (e e_1 : IntW 1) :
  select (LLVM.xor e_1 (const? 1 1)) (LLVM.xor e (const? 1 1)) (const? 1 1) ⊑
    select e_1 (const? 1 1) (LLVM.xor e (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_not_false_thm (e e_1 : IntW 1) :
  select (LLVM.xor e_1 (const? 1 1)) (LLVM.xor e (const? 1 1)) (const? 1 0) ⊑
    LLVM.xor (select e_1 (const? 1 1) e) (const? 1 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_true_not_thm (e e_1 : IntW 1) :
  select (LLVM.xor e_1 (const? 1 1)) (const? 1 1) (LLVM.xor e (const? 1 1)) ⊑
    LLVM.xor (select e_1 e (const? 1 0)) (const? 1 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_false_not_thm (e e_1 : IntW 1) :
  select (LLVM.xor e_1 (const? 1 1)) (const? 1 0) (LLVM.xor e (const? 1 1)) ⊑
    select e_1 (LLVM.xor e (const? 1 1)) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or1_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or (LLVM.xor e_2 (const? 1 1)) e_1) e_2 e ⊑ select e_2 (select e_1 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or2_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and (LLVM.xor e_2 (const? 1 1)) e_1) e e_1 ⊑ select e_1 (select e_2 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or1_commuted_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 (LLVM.xor e_1 (const? 1 1))) e_1 e ⊑ select e_1 (select e_2 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or2_commuted_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 (LLVM.xor e_1 (const? 1 1))) e e_2 ⊑ select e_2 (select e_1 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or1_wrong_operand_thm (e e_1 e_2 e_3 : IntW 1) :
  select (LLVM.or (LLVM.xor e_3 (const? 1 1)) e_2) e_1 e ⊑
    select (LLVM.or e_2 (LLVM.xor e_3 (const? 1 1))) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or2_wrong_operand_thm (e e_1 e_2 e_3 : IntW 1) :
  select (LLVM.and (LLVM.xor e_3 (const? 1 1)) e_2) e_1 e ⊑
    select (LLVM.and e_2 (LLVM.xor e_3 (const? 1 1))) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or3_thm (e : IntW 1) (e_1 e_2 : IntW 32) (e_3 : IntW 1) :
  select (LLVM.and e_3 (icmp IntPredicate.eq e_2 e_1)) e e_3 ⊑
    select e_3 (select (icmp IntPredicate.ne e_2 e_1) (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_or3_commuted_thm (e e_1 : IntW 1) (e_2 e_3 : IntW 32) :
  select (LLVM.and (icmp IntPredicate.eq e_3 e_2) e_1) e e_1 ⊑
    select e_1 (select (icmp IntPredicate.ne e_3 e_2) (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and1_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and (LLVM.xor e_2 (const? 1 1)) e_1) e e_2 ⊑ select e_2 (const? 1 1) (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and2_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or (LLVM.xor e_2 (const? 1 1)) e_1) e_1 e ⊑ select e_1 (const? 1 1) (select e_2 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and1_commuted_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 (LLVM.xor e_1 (const? 1 1))) e e_1 ⊑ select e_1 (const? 1 1) (select e_2 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and2_commuted_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 (LLVM.xor e_1 (const? 1 1))) e_2 e ⊑ select e_2 (const? 1 1) (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr64558_thm (e e_1 : IntW 1) : select (LLVM.and (LLVM.xor e_1 (const? 1 1)) e) e e_1 ⊑ LLVM.or e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and3_thm (e : IntW 1) (e_1 e_2 : IntW 32) (e_3 : IntW 1) :
  select (LLVM.or e_3 (icmp IntPredicate.eq e_2 e_1)) e_3 e ⊑
    select e_3 (const? 1 1) (select (icmp IntPredicate.ne e_2 e_1) e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_and3_commuted_thm (e e_1 : IntW 1) (e_2 e_3 : IntW 32) :
  select (LLVM.or (icmp IntPredicate.eq e_3 e_2) e_1) e_1 e ⊑
    select e_1 (const? 1 1) (select (icmp IntPredicate.ne e_3 e_2) e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_or_eq_a_b_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  select (LLVM.or e_2 (icmp IntPredicate.eq e_1 e)) e_1 e ⊑ select e_2 e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_and_ne_a_b_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  select (LLVM.and e_2 (icmp IntPredicate.ne e_1 e)) e_1 e ⊑ select e_2 e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_or_eq_a_b_commuted_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  select (LLVM.or e_2 (icmp IntPredicate.eq e_1 e)) e e_1 ⊑ select e_2 e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_and_ne_a_b_commuted_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  select (LLVM.and e_2 (icmp IntPredicate.ne e_1 e)) e e_1 ⊑ select e_2 e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_or_eq_different_operands_thm (e e_1 e_2 : IntW 8) :
  select (LLVM.or (icmp IntPredicate.eq e_2 e_1) (icmp IntPredicate.eq e e_2)) e_2 e ⊑
    select (icmp IntPredicate.eq e_2 e_1) e_2 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_or_ne_a_b_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  select (LLVM.or e_2 (icmp IntPredicate.ne e_1 e)) e_1 e ⊑ e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_logical_or_eq_a_b_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  select (select e_2 (const? 1 1) (icmp IntPredicate.eq e_1 e)) e_1 e ⊑ select e_2 e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_logical_and_ne_a_b_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  select (select e_2 (icmp IntPredicate.ne e_1 e) (const? 1 0)) e_1 e ⊑ select e_2 e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


