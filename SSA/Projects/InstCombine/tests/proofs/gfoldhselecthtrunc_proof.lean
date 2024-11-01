
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gfoldhselecthtrunc_proof
theorem fold_select_trunc_nuw_true_thm (e e_1 : IntW 8) : select (trunc 1 e_1) e_1 e ⊑ select (trunc 1 e_1) (const? 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_select_trunc_nuw_false_thm (e e_1 : IntW 8) : select (trunc 1 e_1) e e_1 ⊑ select (trunc 1 e_1) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_select_trunc_nsw_true_thm (e e_1 : IntW 128) : select (trunc 1 e_1) e_1 e ⊑ select (trunc 1 e_1) (const? (-1)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_select_trunc_nsw_false_thm (e e_1 : IntW 8) : select (trunc 1 e_1) e e_1 ⊑ select (trunc 1 e_1) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


