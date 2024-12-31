
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsignedhcomparison_proof
theorem scalar_zext_slt_thm (e : IntW 16) :
  icmp IntPredicate.slt (zext 32 e) (const? 32 500) ⊑ icmp IntPredicate.ult e (const? 16 500) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


