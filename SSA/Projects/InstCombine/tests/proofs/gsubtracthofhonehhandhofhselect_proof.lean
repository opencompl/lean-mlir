
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubtracthofhonehhandhofhselect_proof
theorem t0_sub_of_trueval_thm :
  ∀ (e e_1 : IntW 8) (e_2 : IntW 1), sub (select e_2 e_1 e) e_1 ⊑ select e_2 (const? 0) (sub e e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_sub_of_falseval_thm :
  ∀ (e e_1 : IntW 8) (e_2 : IntW 1), sub (select e_2 e_1 e) e ⊑ select e_2 (sub e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


