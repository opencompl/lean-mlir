
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gcasthmulhselect_proof
theorem mul_thm (e e_1 : IntW 32) :
  zext 32 (mul (trunc 8 e_1) (trunc 8 e)) ⊑ LLVM.and (mul e_1 e) (const? 32 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select1_thm (e e_1 e_2 : IntW 32) (e_3 : IntW 1) :
  zext 32 (select e_3 (trunc 8 e_2) (add (trunc 8 e_1) (trunc 8 e))) ⊑
    LLVM.and (select e_3 e_2 (add e_1 e)) (const? 32 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select2_thm (e e_1 e_2 : IntW 8) (e_3 : IntW 1) :
  trunc 8 (select e_3 (zext 32 e_2) (add (zext 32 e_1) (zext 32 e))) ⊑ select e_3 e_2 (add e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo_thm (e : IntW 1) : e ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


