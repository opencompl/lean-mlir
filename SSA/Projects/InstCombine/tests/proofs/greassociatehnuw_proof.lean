
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section greassociatehnuw_proof
theorem reassoc_add_nuw_thm (e : IntW 32) :
  add (add e (const? 32 4) { «nsw» := false, «nuw» := true }) (const? 32 64) { «nsw» := false, «nuw» := true } ⊑
    add e (const? 32 68) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem reassoc_sub_nuw_thm (e : IntW 32) :
  sub (sub e (const? 32 4) { «nsw» := false, «nuw» := true }) (const? 32 64) { «nsw» := false, «nuw» := true } ⊑
    add e (const? 32 (-68)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem reassoc_mul_nuw_thm (e : IntW 32) :
  mul (mul e (const? 32 4) { «nsw» := false, «nuw» := true }) (const? 32 65) { «nsw» := false, «nuw» := true } ⊑
    mul e (const? 32 260) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_reassoc_add_nuw_none_thm (e : IntW 32) :
  add (add e (const? 32 4)) (const? 32 64) { «nsw» := false, «nuw» := true } ⊑ add e (const? 32 68) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_reassoc_add_none_nuw_thm (e : IntW 32) :
  add (add e (const? 32 4) { «nsw» := false, «nuw» := true }) (const? 32 64) ⊑ add e (const? 32 68) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem reassoc_x2_add_nuw_thm (e e_1 : IntW 32) :
  add (add e_1 (const? 32 4) { «nsw» := false, «nuw» := true }) (add e (const? 32 8) { «nsw» := false, «nuw» := true })
      { «nsw» := false, «nuw» := true } ⊑
    add (add e_1 e { «nsw» := false, «nuw» := true }) (const? 32 12) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem reassoc_x2_mul_nuw_thm (e e_1 : IntW 32) :
  mul (mul e_1 (const? 32 5) { «nsw» := false, «nuw» := true }) (mul e (const? 32 9) { «nsw» := false, «nuw» := true })
      { «nsw» := false, «nuw» := true } ⊑
    mul (mul e_1 e) (const? 32 45) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem reassoc_x2_sub_nuw_thm (e e_1 : IntW 32) :
  sub (sub e_1 (const? 32 4) { «nsw» := false, «nuw» := true }) (sub e (const? 32 8) { «nsw» := false, «nuw» := true })
      { «nsw» := false, «nuw» := true } ⊑
    add (sub e_1 e) (const? 32 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_thm (e : IntW 32) :
  add (mul e (const? 32 3) { «nsw» := false, «nuw» := true }) e { «nsw» := false, «nuw» := true } ⊑
    shl e (const? 32 2) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_int_max_thm (e : IntW 32) :
  add (mul e (const? 32 2147483647) { «nsw» := false, «nuw» := true }) e { «nsw» := false, «nuw» := true } ⊑
    shl e (const? 32 31) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_add_mul_nuw_thm (e : IntW 32) :
  add (mul e (const? 32 3)) e { «nsw» := false, «nuw» := true } ⊑ shl e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_add_nuw_mul_thm (e : IntW 32) :
  add (mul e (const? 32 3) { «nsw» := false, «nuw» := true }) e ⊑ shl e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_mul_nuw_var_thm (e e_1 e_2 : IntW 32) :
  add (mul e_2 e_1 { «nsw» := false, «nuw» := true }) (mul e_2 e { «nsw» := false, «nuw» := true })
      { «nsw» := false, «nuw» := true } ⊑
    mul e_2 (add e_1 e) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_add_nuw_mul_mul_nuw_var_thm (e e_1 e_2 : IntW 32) :
  add (mul e_2 e_1) (mul e_2 e { «nsw» := false, «nuw» := true }) { «nsw» := false, «nuw» := true } ⊑
    mul e_2 (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_add_nuw_mul_nuw_mul_var_thm (e e_1 e_2 : IntW 32) :
  add (mul e_2 e_1 { «nsw» := false, «nuw» := true }) (mul e_2 e) { «nsw» := false, «nuw» := true } ⊑
    mul e_2 (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_add_mul_nuw_mul_var_thm (e e_1 e_2 : IntW 32) :
  add (mul e_2 e_1 { «nsw» := false, «nuw» := true }) (mul e_2 e { «nsw» := false, «nuw» := true }) ⊑
    mul e_2 (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


