
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section greassociatehnuw_proof
theorem reassoc_add_nuw_thm :
  ∀ (e : IntW 32),
    add (add e (const? 4) { «nsw» := false, «nuw» := true }) (const? 64) { «nsw» := false, «nuw» := true } ⊑
      add e (const? 68) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reassoc_sub_nuw_thm :
  ∀ (e : IntW 32),
    sub (sub e (const? 4) { «nsw» := false, «nuw» := true }) (const? 64) { «nsw» := false, «nuw» := true } ⊑
      add e (const? (-68)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reassoc_mul_nuw_thm :
  ∀ (e : IntW 32),
    mul (mul e (const? 4) { «nsw» := false, «nuw» := true }) (const? 65) { «nsw» := false, «nuw» := true } ⊑
      mul e (const? 260) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem no_reassoc_add_nuw_none_thm :
  ∀ (e : IntW 32), add (add e (const? 4)) (const? 64) { «nsw» := false, «nuw» := true } ⊑ add e (const? 68) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem no_reassoc_add_none_nuw_thm :
  ∀ (e : IntW 32), add (add e (const? 4) { «nsw» := false, «nuw» := true }) (const? 64) ⊑ add e (const? 68) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reassoc_x2_add_nuw_thm :
  ∀ (e e_1 : IntW 32),
    add (add e_1 (const? 4) { «nsw» := false, «nuw» := true }) (add e (const? 8) { «nsw» := false, «nuw» := true })
        { «nsw» := false, «nuw» := true } ⊑
      add (add e_1 e { «nsw» := false, «nuw» := true }) (const? 12) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reassoc_x2_mul_nuw_thm :
  ∀ (e e_1 : IntW 32),
    mul (mul e_1 (const? 5) { «nsw» := false, «nuw» := true }) (mul e (const? 9) { «nsw» := false, «nuw» := true })
        { «nsw» := false, «nuw» := true } ⊑
      mul (mul e_1 e) (const? 45) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem reassoc_x2_sub_nuw_thm :
  ∀ (e e_1 : IntW 32),
    sub (sub e_1 (const? 4) { «nsw» := false, «nuw» := true }) (sub e (const? 8) { «nsw» := false, «nuw» := true })
        { «nsw» := false, «nuw» := true } ⊑
      add (sub e_1 e) (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_thm :
  ∀ (e : IntW 32),
    add (mul e (const? 3) { «nsw» := false, «nuw» := true }) e { «nsw» := false, «nuw» := true } ⊑
      shl e (const? 2) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_int_max_thm :
  ∀ (e : IntW 32),
    add (mul e (const? 2147483647) { «nsw» := false, «nuw» := true }) e { «nsw» := false, «nuw» := true } ⊑
      shl e (const? 31) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_mul_nuw_thm :
  ∀ (e : IntW 32), add (mul e (const? 3)) e { «nsw» := false, «nuw» := true } ⊑ shl e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_thm :
  ∀ (e : IntW 32), add (mul e (const? 3) { «nsw» := false, «nuw» := true }) e ⊑ shl e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_mul_nuw_var_thm :
  ∀ (e e_1 e_2 : IntW 32),
    add (mul e_2 e_1 { «nsw» := false, «nuw» := true }) (mul e_2 e { «nsw» := false, «nuw» := true })
        { «nsw» := false, «nuw» := true } ⊑
      mul e_2 (add e_1 e) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_mul_nuw_var_thm :
  ∀ (e e_1 e_2 : IntW 32),
    add (mul e_2 e_1) (mul e_2 e { «nsw» := false, «nuw» := true }) { «nsw» := false, «nuw» := true } ⊑
      mul e_2 (add e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_mul_var_thm :
  ∀ (e e_1 e_2 : IntW 32),
    add (mul e_2 e_1 { «nsw» := false, «nuw» := true }) (mul e_2 e) { «nsw» := false, «nuw» := true } ⊑
      mul e_2 (add e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem tryFactorization_add_mul_nuw_mul_var_thm :
  ∀ (e e_1 e_2 : IntW 32),
    add (mul e_2 e_1 { «nsw» := false, «nuw» := true }) (mul e_2 e { «nsw» := false, «nuw» := true }) ⊑
      mul e_2 (add e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


