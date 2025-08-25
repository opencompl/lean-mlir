
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section g2008h05h31hBools_proof
theorem foo1_thm (e e_1 : IntW 1) : sub e_1 e ⊑ LLVM.xor e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem foo2_thm (e e_1 : IntW 1) : mul e_1 e ⊑ LLVM.and e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem foo3_thm (e e_1 : IntW 1) : LLVM.udiv e_1 e ⊑ e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem foo4_thm (e e_1 : IntW 1) : LLVM.sdiv e_1 e ⊑ e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
