
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthandhxorhmerge_proof
theorem test1_thm (e✝ e✝¹ e✝² : IntW 57) :
  LLVM.xor (LLVM.and e✝² e✝¹) (LLVM.and e✝² e✝) ⊑ LLVM.and e✝² (LLVM.xor e✝¹ e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ e✝¹ : IntW 23) : LLVM.xor (LLVM.and e✝¹ e✝) (LLVM.or e✝¹ e✝) ⊑ LLVM.xor e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


