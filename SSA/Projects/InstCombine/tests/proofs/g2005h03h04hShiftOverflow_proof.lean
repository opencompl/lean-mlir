
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section g2005h03h04hShiftOverflow_proof
theorem test_thm (e : IntW 64) :
  icmp IntPredicate.ugt (lshr e (const? 64 1)) (const? 64 0) ⊑ icmp IntPredicate.ugt e (const? 64 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
