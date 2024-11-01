
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthofhsymmetrichselects_proof
theorem select_of_symmetric_selects_thm (e e_1 : IntW 32) (e_2 e_3 : IntW 1) :
  select e_3 (select e_2 e_1 e) (select e_2 e e_1) ⊑ select (LLVM.xor e_2 e_3) e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_of_symmetric_selects_negative1_thm (e e_1 : IntW 32) (e_2 e_3 : IntW 1) :
  select e_3 (select e_2 e_1 e) (select e_3 e e_1) ⊑ select e_3 (select e_2 e_1 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_of_symmetric_selects_commuted_thm (e e_1 : IntW 32) (e_2 e_3 : IntW 1) :
  select e_3 (select e_2 e_1 e) (select e_2 e e_1) ⊑ select (LLVM.xor e_2 e_3) e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


