
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gdivhshift_proof
theorem t5_thm :
  ∀ (e e_1 : IntW 1) (e_2 : IntW 32),
    LLVM.udiv e_2 (select e_1 (select e (const? 32) (const? 64)) (shl (const? 1) e_2)) ⊑
      lshr e_2 (select e_1 (select e (const? 5) (const? 6)) e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t7_thm : ∀ (e : IntW 32), LLVM.sdiv (shl e (const? 2)) e ⊑ const? 4 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t10_thm : ∀ (e e_1 : IntW 32), LLVM.sdiv (shl e_1 e) e_1 ⊑ shl (const? 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t12_thm : ∀ (e : IntW 32), LLVM.udiv (shl e (const? 2)) e ⊑ const? 4 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t15_thm : ∀ (e e_1 : IntW 32), LLVM.udiv (shl e_1 e) e_1 ⊑ shl (const? 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_mul_shl_nsw_thm :
  ∀ (e e_1 e_2 : IntW 5), LLVM.sdiv (mul e_2 e_1) (shl e_2 e) ⊑ LLVM.sdiv e_1 (shl (const? 1) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_mul_shl_nsw_exact_commute1_thm :
  ∀ (e e_1 e_2 : IntW 5), LLVM.sdiv (mul e_2 e_1) (shl e_1 e) ⊑ LLVM.sdiv e_2 (shl (const? 1) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_mul_shl_nuw_thm : ∀ (e e_1 e_2 : IntW 5), LLVM.udiv (mul e_2 e_1) (shl e_2 e) ⊑ lshr e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_mul_shl_nuw_exact_commute1_thm : ∀ (e e_1 e_2 : IntW 5), LLVM.udiv (mul e_2 e_1) (shl e_1 e) ⊑ lshr e_2 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_mul_nuw_thm :
  ∀ (e e_1 e_2 : IntW 5), LLVM.udiv (shl e_2 e_1) (mul e_2 e) ⊑ LLVM.udiv (shl (const? 1) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_mul_nuw_swap_thm :
  ∀ (e e_1 e_2 : IntW 5), LLVM.udiv (shl e_2 e_1) (mul e e_2) ⊑ LLVM.udiv (shl (const? 1) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_mul_nuw_exact_thm :
  ∀ (e e_1 e_2 : IntW 5), LLVM.udiv (shl e_2 e_1) (mul e_2 e) ⊑ LLVM.udiv (shl (const? 1) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_lshr_mul_nuw_thm : ∀ (e e_1 e_2 : IntW 8), LLVM.udiv (lshr (mul e_2 e_1) e) e_2 ⊑ lshr e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_shl_shl_nsw2_nuw_thm : ∀ (e e_1 e_2 : IntW 8), LLVM.sdiv (shl e_2 e_1) (shl e e_1) ⊑ LLVM.sdiv e_2 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_shl_nuw_nsw2_thm : ∀ (e e_1 e_2 : IntW 8), LLVM.udiv (shl e_2 e_1) (shl e e_1) ⊑ LLVM.udiv e_2 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_shl_pair_const_thm : ∀ (e : IntW 32), LLVM.sdiv (shl e (const? 2)) (shl e (const? 1)) ⊑ const? 2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_pair_const_thm : ∀ (e : IntW 32), LLVM.udiv (shl e (const? 2)) (shl e (const? 1)) ⊑ const? 2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_shl_pair1_thm :
  ∀ (e e_1 e_2 : IntW 32), LLVM.sdiv (shl e_2 e_1) (shl e_2 e) ⊑ lshr (shl (const? 1) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_shl_pair2_thm :
  ∀ (e e_1 e_2 : IntW 32), LLVM.sdiv (shl e_2 e_1) (shl e_2 e) ⊑ lshr (shl (const? 1) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_shl_pair3_thm :
  ∀ (e e_1 e_2 : IntW 32), LLVM.sdiv (shl e_2 e_1) (shl e_2 e) ⊑ lshr (shl (const? 1) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_pair1_thm :
  ∀ (e e_1 e_2 : IntW 32), LLVM.udiv (shl e_2 e_1) (shl e_2 e) ⊑ lshr (shl (const? 1) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_pair2_thm :
  ∀ (e e_1 e_2 : IntW 32), LLVM.udiv (shl e_2 e_1) (shl e_2 e) ⊑ lshr (shl (const? 1) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_pair3_thm :
  ∀ (e e_1 e_2 : IntW 32), LLVM.udiv (shl e_2 e_1) (shl e_2 e) ⊑ lshr (shl (const? 1) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


