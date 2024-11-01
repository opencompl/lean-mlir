
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gaddnegneg_proof
theorem l_thm (e✝ e✝¹ e✝² : IntW 32) :
  add (add (sub (const? 0) e✝²) (sub (const? 0) e✝¹)) e✝ ⊑ sub e✝ (add e✝² e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


