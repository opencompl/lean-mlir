
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section g2009h03h24hInfLoop_proof
theorem test_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 32 3968) e) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e { «nsw» := false, «nuw» := true }) (const? 32 3968))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
