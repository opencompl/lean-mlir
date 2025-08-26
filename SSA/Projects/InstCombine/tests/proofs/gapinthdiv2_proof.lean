
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gapinthdiv2_proof
theorem test1_thm (e : IntW 333) : LLVM.udiv e (const? 333 70368744177664) ⊑ lshr e (const? 333 46) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test2_thm (e : IntW 499) :
  LLVM.udiv e (shl (const? 499 4096) (const? 499 197)) ⊑ lshr e (const? 499 209) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test3_thm (e : IntW 1) (e_1 : IntW 599) :
  LLVM.udiv e_1 (select e (const? 599 70368744177664) (const? 599 4096)) ⊑
    lshr e_1 (select e (const? 599 46) (const? 599 12)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
