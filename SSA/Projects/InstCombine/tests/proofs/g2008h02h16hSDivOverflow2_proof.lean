
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section g2008h02h16hSDivOverflow2_proof
theorem i_thm (e : IntW 8) :
  LLVM.sdiv (LLVM.sdiv e (const? 8 (-3))) (const? 8 (-3)) ⊑ LLVM.sdiv e (const? 8 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


