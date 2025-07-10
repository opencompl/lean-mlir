
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthsafehimpliedcondhtransforms_proof
theorem a_true_implies_b_true_proof.a_true_implies_b_true_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  select (icmp IntPred.ugt e (const? 8 20)) (select (icmp IntPred.ugt e (const? 8 10)) e_1 e_2) (const? 1 0) ⊑
    select (icmp IntPred.ugt e (const? 8 20)) e_1 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_true_implies_b_true2_proof.a_true_implies_b_true2_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  LLVM.and (icmp IntPred.ugt e (const? 8 20)) (select (icmp IntPred.ugt e (const? 8 10)) e_1 e_2) ⊑
    select (icmp IntPred.ugt e (const? 8 20)) e_1 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_true_implies_b_true2_comm_proof.a_true_implies_b_true2_comm_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  LLVM.and (select (icmp IntPred.ugt e (const? 8 10)) e_1 e_2) (icmp IntPred.ugt e (const? 8 20)) ⊑
    select (icmp IntPred.ugt e (const? 8 20)) e_1 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_true_implies_b_false_proof.a_true_implies_b_false_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  select (icmp IntPred.ugt e (const? 8 20)) (select (icmp IntPred.ult e (const? 8 10)) e_1 e_2) (const? 1 0) ⊑
    select (icmp IntPred.ugt e (const? 8 20)) e_2 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_true_implies_b_false2_proof.a_true_implies_b_false2_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  LLVM.and (icmp IntPred.ugt e (const? 8 20)) (select (icmp IntPred.eq e (const? 8 10)) e_1 e_2) ⊑
    select (icmp IntPred.ugt e (const? 8 20)) e_2 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_true_implies_b_false2_comm_proof.a_true_implies_b_false2_comm_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  LLVM.and (select (icmp IntPred.eq e (const? 8 10)) e_1 e_2) (icmp IntPred.ugt e (const? 8 20)) ⊑
    select (icmp IntPred.ugt e (const? 8 20)) e_2 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_false_implies_b_true_proof.a_false_implies_b_true_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  select (icmp IntPred.ugt e (const? 8 10)) (const? 1 1) (select (icmp IntPred.ult e (const? 8 20)) e_1 e_2) ⊑
    select (icmp IntPred.ugt e (const? 8 10)) (const? 1 1) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_false_implies_b_true2_proof.a_false_implies_b_true2_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  LLVM.or (icmp IntPred.ugt e (const? 8 10)) (select (icmp IntPred.ult e (const? 8 20)) e_1 e_2) ⊑
    select (icmp IntPred.ugt e (const? 8 10)) (const? 1 1) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_false_implies_b_true2_comm_proof.a_false_implies_b_true2_comm_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  LLVM.or (select (icmp IntPred.ult e (const? 8 20)) e_1 e_2) (icmp IntPred.ugt e (const? 8 10)) ⊑
    select (icmp IntPred.ugt e (const? 8 10)) (const? 1 1) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_false_implies_b_false_proof.a_false_implies_b_false_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  select (icmp IntPred.ugt e (const? 8 10)) (const? 1 1) (select (icmp IntPred.ugt e (const? 8 20)) e_1 e_2) ⊑
    select (icmp IntPred.ugt e (const? 8 10)) (const? 1 1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_false_implies_b_false2_proof.a_false_implies_b_false2_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  LLVM.or (icmp IntPred.ugt e (const? 8 10)) (select (icmp IntPred.ugt e (const? 8 20)) e_1 e_2) ⊑
    select (icmp IntPred.ugt e (const? 8 10)) (const? 1 1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem a_false_implies_b_false2_comm_proof.a_false_implies_b_false2_comm_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  LLVM.or (select (icmp IntPred.ugt e (const? 8 20)) e_1 e_2) (icmp IntPred.ugt e (const? 8 10)) ⊑
    select (icmp IntPred.ugt e (const? 8 10)) (const? 1 1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
