
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section g2004h09h28hBadShiftAndSetCC_proof
theorem test_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl e (const? 32 8)) (const? 32 (-16777216))) (const? 32 167772160) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 16711680)) (const? 32 655360) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


