
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcasthselect_proof
theorem trunc_proof.trunc_thm_1 (e e_1 e_2 : IntW 32) :
  trunc 16 (select (icmp IntPred.ult e e_1) (const? 32 42) e_2) ⊑
    select (icmp IntPred.ult e e_1) (const? 16 42) (trunc 16 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
