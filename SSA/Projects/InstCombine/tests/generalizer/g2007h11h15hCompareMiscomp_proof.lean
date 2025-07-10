
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section g2007h11h15hCompareMiscomp_proof
theorem test_proof.test_thm_1 (e : IntW 32) :
  LLVM.and (icmp IntPred.sgt e (const? 32 (-1))) (icmp IntPred.eq e (const? 32 1)) ⊑
    icmp IntPred.eq e (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_logical_proof.test_logical_thm_1 (e : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 (-1))) (icmp IntPred.eq e (const? 32 1)) (const? 1 0) ⊑
    icmp IntPred.eq e (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
