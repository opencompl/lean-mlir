
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section greassociatehnuw_proof
theorem reassoc_add_nuw_proof.reassoc_add_nuw_thm_1 (e : IntW 32) :
  add (add e (const? 32 4) { «nuw» := true }) (const? 32 64) { «nuw» := true } ⊑
    add e (const? 32 68) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem reassoc_sub_nuw_proof.reassoc_sub_nuw_thm_1 (e : IntW 32) :
  sub (sub e (const? 32 4) { «nuw» := true }) (const? 32 64) { «nuw» := true } ⊑ add e (const? 32 (-68)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem reassoc_mul_nuw_proof.reassoc_mul_nuw_thm_1 (e : IntW 32) :
  mul (mul e (const? 32 4) { «nuw» := true }) (const? 32 65) { «nuw» := true } ⊑
    mul e (const? 32 260) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_reassoc_add_nuw_none_proof.no_reassoc_add_nuw_none_thm_1 (e : IntW 32) :
  add (add e (const? 32 4)) (const? 32 64) { «nuw» := true } ⊑ add e (const? 32 68) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_reassoc_add_none_nuw_proof.no_reassoc_add_none_nuw_thm_1 (e : IntW 32) :
  add (add e (const? 32 4) { «nuw» := true }) (const? 32 64) ⊑ add e (const? 32 68) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem reassoc_x2_add_nuw_proof.reassoc_x2_add_nuw_thm_1 (e e_1 : IntW 32) :
  add (add e (const? 32 4) { «nuw» := true }) (add e_1 (const? 32 8) { «nuw» := true }) { «nuw» := true } ⊑
    add (add e e_1 { «nuw» := true }) (const? 32 12) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem reassoc_x2_mul_nuw_proof.reassoc_x2_mul_nuw_thm_1 (e e_1 : IntW 32) :
  mul (mul e (const? 32 5) { «nuw» := true }) (mul e_1 (const? 32 9) { «nuw» := true }) { «nuw» := true } ⊑
    mul (mul e e_1) (const? 32 45) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem reassoc_x2_sub_nuw_proof.reassoc_x2_sub_nuw_thm_1 (e e_1 : IntW 32) :
  sub (sub e (const? 32 4) { «nuw» := true }) (sub e_1 (const? 32 8) { «nuw» := true }) { «nuw» := true } ⊑
    add (sub e e_1) (const? 32 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_add_nuw_mul_nuw_proof.tryFactorization_add_nuw_mul_nuw_thm_1 (e : IntW 32) :
  add (mul e (const? 32 3) { «nuw» := true }) e { «nuw» := true } ⊑ shl e (const? 32 2) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_add_nuw_mul_nuw_int_max_proof.tryFactorization_add_nuw_mul_nuw_int_max_thm_1 (e : IntW 32) :
  add (mul e (const? 32 2147483647) { «nuw» := true }) e { «nuw» := true } ⊑
    shl e (const? 32 31) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_add_mul_nuw_proof.tryFactorization_add_mul_nuw_thm_1 (e : IntW 32) :
  add (mul e (const? 32 3)) e { «nuw» := true } ⊑ shl e (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_add_nuw_mul_proof.tryFactorization_add_nuw_mul_thm_1 (e : IntW 32) :
  add (mul e (const? 32 3) { «nuw» := true }) e ⊑ shl e (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_add_nuw_mul_nuw_mul_nuw_var_proof.tryFactorization_add_nuw_mul_nuw_mul_nuw_var_thm_1 (e e_1 e_2 : IntW 32) :
  add (mul e e_1 { «nuw» := true }) (mul e e_2 { «nuw» := true }) { «nuw» := true } ⊑
    mul e (add e_1 e_2) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_add_nuw_mul_mul_nuw_var_proof.tryFactorization_add_nuw_mul_mul_nuw_var_thm_1 (e e_1 e_2 : IntW 32) :
  add (mul e e_1) (mul e e_2 { «nuw» := true }) { «nuw» := true } ⊑ mul e (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_add_nuw_mul_nuw_mul_var_proof.tryFactorization_add_nuw_mul_nuw_mul_var_thm_1 (e e_1 e_2 : IntW 32) :
  add (mul e e_1 { «nuw» := true }) (mul e e_2) { «nuw» := true } ⊑ mul e (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_add_mul_nuw_mul_var_proof.tryFactorization_add_mul_nuw_mul_var_thm_1 (e e_1 e_2 : IntW 32) :
  add (mul e e_1 { «nuw» := true }) (mul e e_2 { «nuw» := true }) ⊑ mul e (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
