
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section grangehcheck_proof
theorem test_and1_proof.test_and1_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.sge e (const? 32 0)) (icmp IntPred.slt e (LLVM.and e_1 (const? 32 2147483647))) ⊑
    icmp IntPred.ult e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_and1_logical_proof.test_and1_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sge e (const? 32 0)) (icmp IntPred.slt e (LLVM.and e_1 (const? 32 2147483647))) (const? 1 0) ⊑
    select (icmp IntPred.sgt e (const? 32 (-1))) (icmp IntPred.slt e (LLVM.and e_1 (const? 32 2147483647)))
      (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_and2_proof.test_and2_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.sgt e (const? 32 (-1))) (icmp IntPred.sle e (LLVM.and e_1 (const? 32 2147483647))) ⊑
    icmp IntPred.ule e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_and3_proof.test_and3_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.sgt (LLVM.and e_1 (const? 32 2147483647)) e) (icmp IntPred.sge e (const? 32 0)) ⊑
    icmp IntPred.ult e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_and3_logical_proof.test_and3_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sgt (LLVM.and e_1 (const? 32 2147483647)) e) (icmp IntPred.sge e (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.ult e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_and4_proof.test_and4_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.sge (LLVM.and e_1 (const? 32 2147483647)) e) (icmp IntPred.sge e (const? 32 0)) ⊑
    icmp IntPred.ule e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_and4_logical_proof.test_and4_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sge (LLVM.and e_1 (const? 32 2147483647)) e) (icmp IntPred.sge e (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.ule e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or1_proof.test_or1_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.slt e (const? 32 0)) (icmp IntPred.sge e (LLVM.and e_1 (const? 32 2147483647))) ⊑
    icmp IntPred.uge e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or2_proof.test_or2_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.sle e (const? 32 (-1))) (icmp IntPred.sgt e (LLVM.and e_1 (const? 32 2147483647))) ⊑
    icmp IntPred.ugt e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or2_logical_proof.test_or2_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sle e (const? 32 (-1))) (const? 1 1) (icmp IntPred.sgt e (LLVM.and e_1 (const? 32 2147483647))) ⊑
    select (icmp IntPred.slt e (const? 32 0)) (const? 1 1)
      (icmp IntPred.sgt e (LLVM.and e_1 (const? 32 2147483647))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or3_proof.test_or3_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.sle (LLVM.and e_1 (const? 32 2147483647)) e) (icmp IntPred.slt e (const? 32 0)) ⊑
    icmp IntPred.uge e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or3_logical_proof.test_or3_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sle (LLVM.and e_1 (const? 32 2147483647)) e) (const? 1 1) (icmp IntPred.slt e (const? 32 0)) ⊑
    icmp IntPred.uge e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or4_proof.test_or4_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.slt (LLVM.and e_1 (const? 32 2147483647)) e) (icmp IntPred.slt e (const? 32 0)) ⊑
    icmp IntPred.ugt e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_or4_logical_proof.test_or4_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.slt (LLVM.and e_1 (const? 32 2147483647)) e) (const? 1 1) (icmp IntPred.slt e (const? 32 0)) ⊑
    icmp IntPred.ugt e (LLVM.and e_1 (const? 32 2147483647)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negative1_logical_proof.negative1_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.slt e (LLVM.and e_1 (const? 32 2147483647))) (icmp IntPred.sgt e (const? 32 0)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.slt e (LLVM.and e_1 (const? 32 2147483647))) (icmp IntPred.sgt e (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negative2_proof.negative2_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.slt e e_1) (icmp IntPred.sge e (const? 32 0)) ⊑
    LLVM.and (icmp IntPred.slt e e_1) (icmp IntPred.sgt e (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negative2_logical_proof.negative2_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.slt e e_1) (icmp IntPred.sge e (const? 32 0)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.slt e e_1) (icmp IntPred.sgt e (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negative3_proof.negative3_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPred.slt e (LLVM.and e_2 (const? 32 2147483647))) (icmp IntPred.sge e_1 (const? 32 0)) ⊑
    LLVM.and (icmp IntPred.slt e (LLVM.and e_2 (const? 32 2147483647))) (icmp IntPred.sgt e_1 (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negative3_logical_proof.negative3_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.slt e (LLVM.and e_2 (const? 32 2147483647))) (icmp IntPred.sge e_1 (const? 32 0)) (const? 1 0) ⊑
    select (icmp IntPred.slt e (LLVM.and e_2 (const? 32 2147483647))) (icmp IntPred.sgt e_1 (const? 32 (-1)))
      (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negative4_proof.negative4_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.ne e (LLVM.and e_1 (const? 32 2147483647))) (icmp IntPred.sge e (const? 32 0)) ⊑
    LLVM.and (icmp IntPred.ne e (LLVM.and e_1 (const? 32 2147483647))) (icmp IntPred.sgt e (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negative4_logical_proof.negative4_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne e (LLVM.and e_1 (const? 32 2147483647))) (icmp IntPred.sge e (const? 32 0)) (const? 1 0) ⊑
    LLVM.and (icmp IntPred.ne e (LLVM.and e_1 (const? 32 2147483647))) (icmp IntPred.sgt e (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negative5_proof.negative5_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.slt e (LLVM.and e_1 (const? 32 2147483647))) (icmp IntPred.sge e (const? 32 0)) ⊑
    const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem negative5_logical_proof.negative5_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.slt e (LLVM.and e_1 (const? 32 2147483647))) (const? 1 1) (icmp IntPred.sge e (const? 32 0)) ⊑
    const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
