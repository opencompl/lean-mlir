
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gbinophandhshifts_proof
theorem shl_and_and_thm :
  ∀ (e e_1 : IntW 8),
    LLVM.and (shl e_1 (const? 4)) (LLVM.and (shl e (const? 4)) (const? 88)) ⊑
      LLVM.and (shl (LLVM.and e e_1) (const? 4)) (const? 80) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_and_and_fail_thm :
  ∀ (e e_1 : IntW 8),
    LLVM.and (shl e_1 (const? 4)) (LLVM.and (shl e (const? 5)) (const? 88)) ⊑
      LLVM.and (shl e_1 (const? 4)) (LLVM.and (shl e (const? 5)) (const? 64)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_add_thm :
  ∀ (e e_1 : IntW 8),
    add (shl e_1 (const? 2)) (add (shl e (const? 2)) (const? 48)) ⊑
      add (shl (add e e_1) (const? 2)) (const? 48) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_and_xor_thm :
  ∀ (e e_1 : IntW 8),
    LLVM.xor (shl e_1 (const? 1)) (LLVM.and (shl e (const? 1)) (const? 20)) ⊑
      shl (LLVM.xor (LLVM.and e (const? 10)) e_1) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_and_add_thm :
  ∀ (e e_1 : IntW 8),
    add (shl e_1 (const? 1)) (LLVM.and (shl e (const? 1)) (const? 119)) ⊑
      shl (add (LLVM.and e (const? 59)) e_1) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_or_and_thm :
  ∀ (e e_1 : IntW 8),
    LLVM.and (LLVM.or (lshr e_1 (const? 5)) (const? (-58))) (lshr e (const? 5)) ⊑
      lshr (LLVM.and (LLVM.or e_1 (const? (-64))) e) (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_or_or_fail_thm :
  ∀ (e e_1 : IntW 8),
    LLVM.or (lshr e_1 (const? 5)) (LLVM.or (lshr e (const? 5)) (const? (-58))) ⊑
      LLVM.or (lshr (LLVM.or e e_1) (const? 5)) (const? (-58)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_or_or_no_const_thm :
  ∀ (e e_1 e_2 e_3 : IntW 8),
    LLVM.or (lshr e_3 e_2) (LLVM.or (lshr e_1 e_2) e) ⊑ LLVM.or (lshr (LLVM.or e_1 e_3) e_2) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_xor_xor_no_const_thm :
  ∀ (e e_1 e_2 e_3 : IntW 8),
    LLVM.xor (shl e_3 e_2) (LLVM.xor (shl e_1 e_2) e) ⊑ LLVM.xor (shl (LLVM.xor e_1 e_3) e_2) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_add_no_const_thm :
  ∀ (e e_1 e_2 e_3 : IntW 8), add (shl e_3 e_2) (add (shl e_1 e_2) e) ⊑ add (shl (add e_1 e_3) e_2) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_xor_or_good_mask_thm :
  ∀ (e e_1 : IntW 8),
    LLVM.or (lshr e_1 (const? 4)) (LLVM.xor (lshr e (const? 4)) (const? 48)) ⊑
      LLVM.or (lshr (LLVM.or e e_1) (const? 4)) (const? 48) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_xor_xor_good_mask_thm :
  ∀ (e e_1 : IntW 8),
    LLVM.xor (shl e_1 (const? 1)) (LLVM.xor (shl e (const? 1)) (const? 88)) ⊑
      LLVM.xor (shl (LLVM.xor e e_1) (const? 1)) (const? 88) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_xor_xor_bad_mask_distribute_thm :
  ∀ (e e_1 : IntW 8),
    LLVM.xor (shl e_1 (const? 1)) (LLVM.xor (shl e (const? 1)) (const? (-68))) ⊑
      LLVM.xor (shl (LLVM.xor e e_1) (const? 1)) (const? (-68)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_and_thm :
  ∀ (e e_1 : IntW 8),
    LLVM.and (shl e_1 (const? 1)) (add (shl e (const? 1)) (const? 123)) ⊑
      shl (LLVM.and (add e (const? 61)) e_1) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ashr_not_thm :
  ∀ (e e_1 e_2 : IntW 8),
    LLVM.and (ashr e_2 e_1) (LLVM.xor (ashr e e_1) (const? (-1))) ⊑
      ashr (LLVM.and (LLVM.xor e (const? (-1))) e_2) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ashr_not_commuted_thm :
  ∀ (e e_1 e_2 : IntW 8),
    LLVM.and (LLVM.xor (ashr e_2 e_1) (const? (-1))) (ashr e e_1) ⊑
      ashr (LLVM.and (LLVM.xor e_2 (const? (-1))) e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_ashr_not_thm :
  ∀ (e e_1 e_2 : IntW 8),
    LLVM.or (ashr e_2 e_1) (LLVM.xor (ashr e e_1) (const? (-1))) ⊑
      ashr (LLVM.or (LLVM.xor e (const? (-1))) e_2) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_ashr_not_commuted_thm :
  ∀ (e e_1 e_2 : IntW 8),
    LLVM.or (LLVM.xor (ashr e_2 e_1) (const? (-1))) (ashr e e_1) ⊑
      ashr (LLVM.or (LLVM.xor e_2 (const? (-1))) e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_ashr_not_thm :
  ∀ (e e_1 e_2 : IntW 8),
    LLVM.xor (ashr e_2 e_1) (LLVM.xor (ashr e e_1) (const? (-1))) ⊑
      LLVM.xor (ashr (LLVM.xor e e_2) e_1) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_ashr_not_commuted_thm :
  ∀ (e e_1 e_2 : IntW 8),
    LLVM.xor (LLVM.xor (ashr e_2 e_1) (const? (-1))) (ashr e e_1) ⊑
      LLVM.xor (ashr (LLVM.xor e_2 e) e_1) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_ashr_not_fail_lshr_ashr_thm :
  ∀ (e e_1 e_2 : IntW 8),
    LLVM.xor (lshr e_2 e_1) (LLVM.xor (ashr e e_1) (const? (-1))) ⊑
      LLVM.xor (LLVM.xor (ashr e e_1) (lshr e_2 e_1)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_ashr_not_fail_ashr_lshr_thm :
  ∀ (e e_1 e_2 : IntW 8),
    LLVM.xor (ashr e_2 e_1) (LLVM.xor (lshr e e_1) (const? (-1))) ⊑
      LLVM.xor (LLVM.xor (lshr e e_1) (ashr e_2 e_1)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_ashr_not_fail_invalid_xor_constant_thm :
  ∀ (e e_1 e_2 : IntW 8),
    LLVM.xor (ashr e_2 e_1) (LLVM.xor (ashr e e_1) (const? (-2))) ⊑
      LLVM.xor (ashr (LLVM.xor e e_2) e_1) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


