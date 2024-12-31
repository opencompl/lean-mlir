
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section g2005h04h07hUDivSelectCrash_proof
theorem test_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.udiv e_1 (select e (const? 32 8) (const? 32 1)) ⊑ lshr e_1 (select e (const? 32 3) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


