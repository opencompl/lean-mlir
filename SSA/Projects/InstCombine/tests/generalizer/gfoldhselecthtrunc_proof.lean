
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gfoldhselecthtrunc_proof
theorem fold_select_trunc_nuw_true_proof.fold_select_trunc_nuw_true_thm_1 (e e_1 : IntW 8) :
  select (trunc 1 e { «nuw» := true }) e e_1 ⊑ select (trunc 1 e { «nuw» := true }) (const? 8 1) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_select_trunc_nuw_false_proof.fold_select_trunc_nuw_false_thm_1 (e e_1 : IntW 8) :
  select (trunc 1 e { «nuw» := true }) e_1 e ⊑ select (trunc 1 e { «nuw» := true }) e_1 (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_select_trunc_nsw_true_proof.fold_select_trunc_nsw_true_thm_1 (e e_1 : IntW 128) :
  select (trunc 1 e { «nsw» := true }) e e_1 ⊑ select (trunc 1 e { «nsw» := true }) (const? 128 (-1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_select_trunc_nsw_false_proof.fold_select_trunc_nsw_false_thm_1 (e e_1 : IntW 8) :
  select (trunc 1 e { «nsw» := true }) e_1 e ⊑ select (trunc 1 e { «nsw» := true }) e_1 (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
