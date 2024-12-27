
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gfoldhselecthtrunc_proof
theorem fold_select_trunc_nuw_true_thm (e e_1 : IntW 8) :
  select (trunc 1 e_1 { «nsw» := false, «nuw» := true }) e_1 e ⊑
    select (trunc 1 e_1 { «nsw» := false, «nuw» := true }) (const? 8 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_select_trunc_nuw_false_thm (e e_1 : IntW 8) :
  select (trunc 1 e_1 { «nsw» := false, «nuw» := true }) e e_1 ⊑
    select (trunc 1 e_1 { «nsw» := false, «nuw» := true }) e (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_select_trunc_nsw_true_thm (e e_1 : IntW 128) :
  select (trunc 1 e_1 { «nsw» := true, «nuw» := false }) e_1 e ⊑
    select (trunc 1 e_1 { «nsw» := true, «nuw» := false }) (const? 128 (-1)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_select_trunc_nsw_false_thm (e e_1 : IntW 8) :
  select (trunc 1 e_1 { «nsw» := true, «nuw» := false }) e e_1 ⊑
    select (trunc 1 e_1 { «nsw» := true, «nuw» := false }) e (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


