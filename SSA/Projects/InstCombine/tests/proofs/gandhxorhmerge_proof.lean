
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gandhxorhmerge_proof
theorem test1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.xor (LLVM.and e✝² e✝¹) (LLVM.and e✝² e✝) ⊑ LLVM.and e✝² (LLVM.xor e✝¹ e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ e✝¹ : IntW 32) : LLVM.xor (LLVM.and e✝¹ e✝) (LLVM.or e✝¹ e✝) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR75692_1_thm (e✝ : IntW 32) : LLVM.and (LLVM.xor e✝ (const? 4)) (LLVM.xor e✝ (const? (-5))) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


