
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gand2_proof
theorem test2_thm : ∀ (e e_1 : IntW 1), LLVM.and (LLVM.and e_1 e) e_1 ⊑ LLVM.and e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_logical_thm :
  ∀ (e e_1 : IntW 1), select (select e_1 e (const? 0)) e_1 (const? 0) ⊑ select e_1 e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm : ∀ (e e_1 : IntW 32), LLVM.and e_1 (LLVM.and e e_1) ⊑ LLVM.and e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm :
  ∀ (e : IntW 64),
    LLVM.and (sub (const? 0) e { «nsw» := true, «nuw» := false }) (const? 1) ⊑ LLVM.and e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm :
  ∀ (e : IntW 64),
    add (sub (const? 0) e { «nsw» := true, «nuw» := false })
        (LLVM.and (sub (const? 0) e { «nsw» := true, «nuw» := false }) (const? 1)) ⊑
      sub (const? 0) (LLVM.and e (const? (-2))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and1_shl1_is_cmp_eq_0_multiuse_thm :
  ∀ (e : IntW 8),
    add (shl (const? 1) e) (LLVM.and (shl (const? 1) e) (const? 1)) ⊑
      add (shl (const? 1) e { «nsw» := false, «nuw» := true })
        (LLVM.and (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1))
        { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and1_lshr1_is_cmp_eq_0_thm : ∀ (e : IntW 8), LLVM.and (lshr (const? 1) e) (const? 1) ⊑ lshr (const? 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and1_lshr1_is_cmp_eq_0_multiuse_thm :
  ∀ (e : IntW 8),
    add (lshr (const? 1) e) (LLVM.and (lshr (const? 1) e) (const? 1)) ⊑
      shl (lshr (const? 1) e) (const? 1) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11_thm :
  ∀ (e e_1 : IntW 32),
    mul (LLVM.and (add (shl e_1 (const? 8)) e) (const? 128)) (shl e_1 (const? 8)) ⊑
      mul (LLVM.and e (const? 128)) (shl e_1 (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_thm :
  ∀ (e e_1 : IntW 32),
    mul (LLVM.and (add e_1 (shl e (const? 8))) (const? 128)) (shl e (const? 8)) ⊑
      mul (LLVM.and e_1 (const? 128)) (shl e (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm :
  ∀ (e e_1 : IntW 32),
    mul (LLVM.and (sub e_1 (shl e (const? 8))) (const? 128)) (shl e (const? 8)) ⊑
      mul (LLVM.and e_1 (const? 128)) (shl e (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test14_thm :
  ∀ (e e_1 : IntW 32),
    mul (LLVM.and (sub (shl e_1 (const? 8)) e) (const? 128)) (shl e_1 (const? 8)) ⊑
      mul (LLVM.and (sub (const? 0) e) (const? 128)) (shl e_1 (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


