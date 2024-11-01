
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubtracthofhonehhandhofhselect_proof
theorem t0_sub_of_trueval_thm (e✝ e✝¹ : IntW 8) (e✝² : IntW 1) :
  sub (select e✝² e✝¹ e✝) e✝¹ ⊑ select e✝² (const? 0) (sub e✝ e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_sub_of_falseval_thm (e✝ e✝¹ : IntW 8) (e✝² : IntW 1) :
  sub (select e✝² e✝¹ e✝) e✝ ⊑ select e✝² (sub e✝¹ e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


