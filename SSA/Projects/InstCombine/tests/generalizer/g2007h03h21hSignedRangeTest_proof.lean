
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section g2007h03h21hSignedRangeTest_proof
theorem test_proof.test_thm_1 (e : IntW 32) :
  icmp IntPred.ne (LLVM.sdiv e (const? 32 12)) (const? 32 (-6)) ⊑
    icmp IntPred.ult (add e (const? 32 71)) (const? 32 (-12)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
