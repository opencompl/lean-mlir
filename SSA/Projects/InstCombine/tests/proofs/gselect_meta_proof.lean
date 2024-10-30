
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselect_meta_proof
theorem shrink_select_thm :
  ∀ (e : IntW 32) (e_1 : IntW 1), trunc 8 (select e_1 e (const? 42)) ⊑ select e_1 (trunc 8 e) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_cond_thm :
  ∀ (e e_1 : IntW 32) (e_2 : IntW 1), select (LLVM.xor e_2 (const? 1)) e_1 e ⊑ select e_2 e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_add_thm :
  ∀ (e e_1 : IntW 64) (e_2 : IntW 1), select e_2 (add e_1 e) e_1 ⊑ add e_1 (select e_2 e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_sub_thm :
  ∀ (e e_1 : IntW 17) (e_2 : IntW 1), select e_2 (sub e_1 e) e_1 ⊑ sub e_1 (select e_2 e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_ashr_thm :
  ∀ (e e_1 : IntW 128) (e_2 : IntW 1), select e_2 (ashr e_1 e) e_1 ⊑ ashr e_1 (select e_2 e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry

