
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gselecthsafehimpliedcondhtransforms_proof
theorem a_true_implies_b_true_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  select (icmp IntPred.ugt e_2 (const? 8 20)) (select (icmp IntPred.ugt e_2 (const? 8 10)) e_1 e)
      (const? 1 0) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 20)) e_1 (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_true_implies_b_true2_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.and (icmp IntPred.ugt e_2 (const? 8 20)) (select (icmp IntPred.ugt e_2 (const? 8 10)) e_1 e) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 20)) e_1 (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_true_implies_b_true2_comm_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.and (select (icmp IntPred.ugt e_2 (const? 8 10)) e_1 e) (icmp IntPred.ugt e_2 (const? 8 20)) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 20)) e_1 (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_true_implies_b_false_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  select (icmp IntPred.ugt e_2 (const? 8 20)) (select (icmp IntPred.ult e_2 (const? 8 10)) e_1 e)
      (const? 1 0) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 20)) e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_true_implies_b_false2_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.and (icmp IntPred.ugt e_2 (const? 8 20)) (select (icmp IntPred.eq e_2 (const? 8 10)) e_1 e) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 20)) e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_true_implies_b_false2_comm_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.and (select (icmp IntPred.eq e_2 (const? 8 10)) e_1 e) (icmp IntPred.ugt e_2 (const? 8 20)) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 20)) e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_true_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  select (icmp IntPred.ugt e_2 (const? 8 10)) (const? 1 1)
      (select (icmp IntPred.ult e_2 (const? 8 20)) e_1 e) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 10)) (const? 1 1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_true2_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.or (icmp IntPred.ugt e_2 (const? 8 10)) (select (icmp IntPred.ult e_2 (const? 8 20)) e_1 e) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 10)) (const? 1 1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_true2_comm_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.or (select (icmp IntPred.ult e_2 (const? 8 20)) e_1 e) (icmp IntPred.ugt e_2 (const? 8 10)) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 10)) (const? 1 1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_false_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  select (icmp IntPred.ugt e_2 (const? 8 10)) (const? 1 1)
      (select (icmp IntPred.ugt e_2 (const? 8 20)) e_1 e) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 10)) (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_false2_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.or (icmp IntPred.ugt e_2 (const? 8 10)) (select (icmp IntPred.ugt e_2 (const? 8 20)) e_1 e) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 10)) (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_false_implies_b_false2_comm_thm (e e_1 : IntW 1) (e_2 : IntW 8) :
  LLVM.or (select (icmp IntPred.ugt e_2 (const? 8 20)) e_1 e) (icmp IntPred.ugt e_2 (const? 8 10)) ⊑
    select (icmp IntPred.ugt e_2 (const? 8 10)) (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
