
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section g2006h04h28hShiftShiftLongLong_proof
theorem test_thm (e : IntW 64) :
  ashr (shl e (const? 64 16)) (const? 64 16) ⊑ ashr (shl e (const? 64 16)) (const? 64 16) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
