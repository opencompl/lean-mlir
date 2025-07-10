
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section g2008h07h08hShiftOneAndOne_proof
theorem PR2330_proof.PR2330_thm_1 (e : IntW 32) :
  icmp IntPred.eq (LLVM.and (shl (const? 32 1) e) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPred.ne e (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
