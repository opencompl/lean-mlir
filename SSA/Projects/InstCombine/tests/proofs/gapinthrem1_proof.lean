
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gapinthrem1_proof
theorem test1_thm (e : IntW 33) : urem e (const? 33 4096) ⊑ LLVM.and e (const? 33 4095) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test2_thm (e : IntW 49) :
  urem e (shl (const? 49 4096) (const? 49 11)) ⊑ LLVM.and e (const? 49 8388607) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test3_thm (e : IntW 1) (e_1 : IntW 59) :
  urem e_1 (select e (const? 59 70368744177664) (const? 59 4096)) ⊑
    LLVM.and e_1 (select e (const? 59 70368744177663) (const? 59 4095)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
