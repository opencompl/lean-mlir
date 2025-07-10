
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gxorhofhor_proof
theorem t1_proof.t1_thm_1 (e : IntW 4) :
  LLVM.xor (LLVM.or e (const? 4 (-4))) (const? 4 (-6)) ⊑ LLVM.xor (LLVM.and e (const? 4 3)) (const? 4 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
