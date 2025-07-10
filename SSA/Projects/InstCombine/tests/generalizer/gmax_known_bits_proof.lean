
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gmax_known_bits_proof
theorem foo_proof.foo_thm_1 (e : IntW 16) :
  LLVM.and
      (trunc 16
        (select (icmp IntPred.ult (zext 32 (LLVM.and e (const? 16 255))) (const? 32 255))
          (zext 32 (LLVM.and e (const? 16 255))) (const? 32 255)))
      (const? 16 255) ⊑
    LLVM.and e (const? 16 255) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
