
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h05h31hBools_proof
theorem foo1_thm (e✝ e✝¹ : IntW 1) : sub e✝¹ e✝ ⊑ LLVM.xor e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem foo2_thm (e✝ e✝¹ : IntW 1) : mul e✝¹ e✝ ⊑ LLVM.and e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem foo3_thm (e✝ e✝¹ : IntW 1) : LLVM.udiv e✝¹ e✝ ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem foo4_thm (e✝ e✝¹ : IntW 1) : LLVM.sdiv e✝¹ e✝ ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


