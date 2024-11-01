
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubtracthfromhonehhandhofhselect_proof
theorem t0_sub_from_trueval_thm (e✝ : IntW 8) (e✝¹ : IntW 1) (e✝² : IntW 8) :
  sub e✝² (select e✝¹ e✝² e✝) ⊑ select e✝¹ (const? 0) (sub e✝² e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_sub_from_falseval_thm (e✝ : IntW 8) (e✝¹ : IntW 1) (e✝² : IntW 8) :
  sub e✝² (select e✝¹ e✝ e✝²) ⊑ select e✝¹ (sub e✝² e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


