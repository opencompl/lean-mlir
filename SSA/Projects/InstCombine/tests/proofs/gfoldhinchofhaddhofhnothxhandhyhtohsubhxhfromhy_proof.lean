
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gfoldhinchofhaddhofhnothxhandhyhtohsubhxhfromhy_proof
theorem t0_thm (e✝ e✝¹ : IntW 32) : add (add (LLVM.xor e✝¹ (const? (-1))) e✝) (const? 1) ⊑ sub e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n12_thm (e✝ e✝¹ : IntW 32) :
  add (add (LLVM.xor e✝¹ (const? (-1))) e✝) (const? 2) ⊑ add (add e✝ (LLVM.xor e✝¹ (const? (-1)))) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


