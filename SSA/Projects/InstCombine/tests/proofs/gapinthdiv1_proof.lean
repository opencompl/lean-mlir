
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gapinthdiv1_proof
theorem test1_thm (e : IntW 33) : LLVM.udiv e (const? 33 4096) ⊑ lshr e (const? 33 12) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 49) : LLVM.udiv e (shl (const? 49 4096) (const? 49 17)) ⊑ lshr e (const? 49 29) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e : IntW 1) (e_1 : IntW 59) :
  LLVM.udiv e_1 (select e (const? 59 1024) (const? 59 4096)) ⊑
    lshr e_1 (select e (const? 59 10) (const? 59 12)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
