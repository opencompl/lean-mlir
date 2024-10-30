
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section greassociatehnuw_proof
theorem reassoc_add_nuw_thm : ∀ (e : IntW 32), add (add e (const? 4)) (const? 64) ⊑ add e (const? 68) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reassoc_sub_nuw_thm : ∀ (e : IntW 32), sub (sub e (const? 4)) (const? 64) ⊑ add e (const? (-68)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reassoc_mul_nuw_thm : ∀ (e : IntW 32), mul (mul e (const? 4)) (const? 65) ⊑ mul e (const? 260) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem no_reassoc_add_nuw_none_thm : ∀ (e : IntW 32), add (add e (const? 4)) (const? 64) ⊑ add e (const? 68) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem no_reassoc_add_none_nuw_thm : ∀ (e : IntW 32), add (add e (const? 4)) (const? 64) ⊑ add e (const? 68) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reassoc_x2_add_nuw_thm :
  ∀ (e e_1 : IntW 32), add (add e_1 (const? 4)) (add e (const? 8)) ⊑ add (add e_1 e) (const? 12) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reassoc_x2_mul_nuw_thm :
  ∀ (e e_1 : IntW 32), mul (mul e_1 (const? 5)) (mul e (const? 9)) ⊑ mul (mul e_1 e) (const? 45) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reassoc_x2_sub_nuw_thm :
  ∀ (e e_1 : IntW 32), sub (sub e_1 (const? 4)) (sub e (const? 8)) ⊑ add (sub e_1 e) (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_thm : ∀ (e : IntW 32), add (mul e (const? 3)) e ⊑ shl e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_int_max_thm : ∀ (e : IntW 32), add (mul e (const? 2147483647)) e ⊑ shl e (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_mul_nuw_thm : ∀ (e : IntW 32), add (mul e (const? 3)) e ⊑ shl e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_thm : ∀ (e : IntW 32), add (mul e (const? 3)) e ⊑ shl e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_mul_nuw_var_thm : ∀ (e e_1 e_2 : IntW 32), add (mul e_2 e_1) (mul e_2 e) ⊑ mul (add e_1 e) e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_mul_nuw_var_thm : ∀ (e e_1 e_2 : IntW 32), add (mul e_2 e_1) (mul e_2 e) ⊑ mul (add e_1 e) e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_mul_var_thm : ∀ (e e_1 e_2 : IntW 32), add (mul e_2 e_1) (mul e_2 e) ⊑ mul (add e_1 e) e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_mul_nuw_mul_var_thm : ∀ (e e_1 e_2 : IntW 32), add (mul e_2 e_1) (mul e_2 e) ⊑ mul (add e_1 e) e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


