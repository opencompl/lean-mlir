
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gmax_known_bits_proof
theorem foo_thm (e : IntW 16) :
  LLVM.and
      (trunc 16
        (select (icmp IntPredicate.ult (zext 32 (LLVM.and e (const? 16 255))) (const? 32 255))
          (zext 32 (LLVM.and e (const? 16 255))) (const? 32 255)))
      (const? 16 255) ⊑
    LLVM.and e (const? 16 255) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
