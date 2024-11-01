
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthshifthsimplify_proof
theorem test0_thm (e✝ e✝¹ e✝² : IntW 41) : LLVM.and (shl e✝² e✝¹) (shl e✝ e✝¹) ⊑ shl (LLVM.and e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test1_thm (e✝ e✝¹ e✝² : IntW 57) : LLVM.or (lshr e✝² e✝¹) (lshr e✝ e✝¹) ⊑ lshr (LLVM.or e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ e✝¹ e✝² : IntW 49) : LLVM.xor (ashr e✝² e✝¹) (ashr e✝ e✝¹) ⊑ ashr (LLVM.xor e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


