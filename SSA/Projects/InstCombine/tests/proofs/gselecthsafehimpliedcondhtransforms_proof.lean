
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gselecthsafehimpliedcondhtransforms_proof
theorem a_true_implies_b_true_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  select (icmp IntPredicate.ugt e_2 (const? 8 20)) (select (icmp IntPredicate.ugt e_2 (const? 8 10)) e_1 e)
      (const? 1 0) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 20)) e_1 (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_true_implies_b_true2_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt e_2 (const? 8 20)) (select (icmp IntPredicate.ugt e_2 (const? 8 10)) e_1 e) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 20)) e_1 (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_true_implies_b_true2_comm_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e_2 (const? 8 10)) e_1 e) (icmp IntPredicate.ugt e_2 (const? 8 20)) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 20)) e_1 (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_true_implies_b_false_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  select (icmp IntPredicate.ugt e_2 (const? 8 20)) (select (icmp IntPredicate.ult e_2 (const? 8 10)) e_1 e)
      (const? 1 0) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 20)) e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_true_implies_b_false2_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt e_2 (const? 8 20)) (select (icmp IntPredicate.eq e_2 (const? 8 10)) e_1 e) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 20)) e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_true_implies_b_false2_comm_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.and (select (icmp IntPredicate.eq e_2 (const? 8 10)) e_1 e) (icmp IntPredicate.ugt e_2 (const? 8 20)) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 20)) e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_true_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  select (icmp IntPredicate.ugt e_2 (const? 8 10)) (const? 1 1)
      (select (icmp IntPredicate.ult e_2 (const? 8 20)) e_1 e) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 10)) (const? 1 1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_true2_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.or (icmp IntPredicate.ugt e_2 (const? 8 10)) (select (icmp IntPredicate.ult e_2 (const? 8 20)) e_1 e) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 10)) (const? 1 1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_true2_comm_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.or (select (icmp IntPredicate.ult e_2 (const? 8 20)) e_1 e) (icmp IntPredicate.ugt e_2 (const? 8 10)) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 10)) (const? 1 1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_false_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  select (icmp IntPredicate.ugt e_2 (const? 8 10)) (const? 1 1)
      (select (icmp IntPredicate.ugt e_2 (const? 8 20)) e_1 e) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 10)) (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_false2_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.or (icmp IntPredicate.ugt e_2 (const? 8 10)) (select (icmp IntPredicate.ugt e_2 (const? 8 20)) e_1 e) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 10)) (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_false2_comm_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.or (select (icmp IntPredicate.ugt e_2 (const? 8 20)) e_1 e) (icmp IntPredicate.ugt e_2 (const? 8 10)) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 8 10)) (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


