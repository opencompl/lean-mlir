
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section g2007h03h25hDoubleShift_proof
theorem test_thm (e : IntW 32) :
  icmp IntPredicate.ne (lshr (shl e (const? 32 12)) (const? 32 12)) (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 1048575)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
