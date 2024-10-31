
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gdivhi1_proof
theorem sdiv_i1_is_op0_thm (e✝ e✝¹ : IntW 1) : LLVM.sdiv e✝¹ e✝ ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_i1_is_op0_thm (e✝ e✝¹ : IntW 1) : LLVM.udiv e✝¹ e✝ ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem srem_i1_is_zero_thm (e✝ e✝¹ : IntW 1) : LLVM.srem e✝¹ e✝ ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_i1_is_zero_thm (e✝ e✝¹ : IntW 1) : urem e✝¹ e✝ ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


