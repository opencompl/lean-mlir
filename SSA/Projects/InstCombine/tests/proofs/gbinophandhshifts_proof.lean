
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gbinophandhshifts_proof
theorem shl_and_and_thm (e✝ e✝¹ : IntW 8) :
  LLVM.and (shl e✝¹ (const? 4)) (LLVM.and (shl e✝ (const? 4)) (const? 88)) ⊑
    LLVM.and (shl (LLVM.and e✝ e✝¹) (const? 4)) (const? 80) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_and_and_fail_thm (e✝ e✝¹ : IntW 8) :
  LLVM.and (shl e✝¹ (const? 4)) (LLVM.and (shl e✝ (const? 5)) (const? 88)) ⊑
    LLVM.and (shl e✝¹ (const? 4)) (LLVM.and (shl e✝ (const? 5)) (const? 64)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_add_thm (e✝ e✝¹ : IntW 8) :
  add (shl e✝¹ (const? 2)) (add (shl e✝ (const? 2)) (const? 48)) ⊑
    add (shl (add e✝ e✝¹) (const? 2)) (const? 48) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_add_fail_thm (e✝ e✝¹ : IntW 8) :
  add (lshr e✝¹ (const? 2)) (add (lshr e✝ (const? 2)) (const? 48)) ⊑
    add (lshr e✝¹ (const? 2)) (add (lshr e✝ (const? 2)) (const? 48) { «nsw» := true, «nuw» := true })
      { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_and_xor_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (shl e✝¹ (const? 1)) (LLVM.and (shl e✝ (const? 1)) (const? 20)) ⊑
    shl (LLVM.xor e✝¹ (LLVM.and e✝ (const? 10))) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_and_add_thm (e✝ e✝¹ : IntW 8) :
  add (shl e✝¹ (const? 1)) (LLVM.and (shl e✝ (const? 1)) (const? 119)) ⊑
    shl (add e✝¹ (LLVM.and e✝ (const? 59))) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_or_and_thm (e✝ e✝¹ : IntW 8) :
  LLVM.and (LLVM.or (lshr e✝¹ (const? 5)) (const? (-58))) (lshr e✝ (const? 5)) ⊑
    lshr (LLVM.and e✝ (LLVM.or e✝¹ (const? (-64)))) (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_or_or_fail_thm (e✝ e✝¹ : IntW 8) :
  LLVM.or (lshr e✝¹ (const? 5)) (LLVM.or (lshr e✝ (const? 5)) (const? (-58))) ⊑
    LLVM.or (lshr (LLVM.or e✝ e✝¹) (const? 5)) (const? (-58)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_or_or_no_const_thm (e✝ e✝¹ e✝² e✝³ : IntW 8) :
  LLVM.or (lshr e✝³ e✝²) (LLVM.or (lshr e✝¹ e✝²) e✝) ⊑ LLVM.or (lshr (LLVM.or e✝¹ e✝³) e✝²) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_xor_xor_no_const_thm (e✝ e✝¹ e✝² e✝³ : IntW 8) :
  LLVM.xor (shl e✝³ e✝²) (LLVM.xor (shl e✝¹ e✝²) e✝) ⊑ LLVM.xor (shl (LLVM.xor e✝¹ e✝³) e✝²) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_add_no_const_thm (e✝ e✝¹ e✝² e✝³ : IntW 8) :
  add (shl e✝³ e✝²) (add (shl e✝¹ e✝²) e✝) ⊑ add (shl (add e✝¹ e✝³) e✝²) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_xor_or_good_mask_thm (e✝ e✝¹ : IntW 8) :
  LLVM.or (lshr e✝¹ (const? 4)) (LLVM.xor (lshr e✝ (const? 4)) (const? 48)) ⊑
    LLVM.or (lshr (LLVM.or e✝ e✝¹) (const? 4)) (const? 48) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_xor_xor_good_mask_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (shl e✝¹ (const? 1)) (LLVM.xor (shl e✝ (const? 1)) (const? 88)) ⊑
    LLVM.xor (shl (LLVM.xor e✝ e✝¹) (const? 1)) (const? 88) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_xor_xor_bad_mask_distribute_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (shl e✝¹ (const? 1)) (LLVM.xor (shl e✝ (const? 1)) (const? (-68))) ⊑
    LLVM.xor (shl (LLVM.xor e✝ e✝¹) (const? 1)) (const? (-68)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_and_thm (e✝ e✝¹ : IntW 8) :
  LLVM.and (shl e✝¹ (const? 1)) (add (shl e✝ (const? 1)) (const? 123)) ⊑
    shl (LLVM.and e✝¹ (add e✝ (const? 61))) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_and_add_fail_thm (e✝ e✝¹ : IntW 8) :
  add (lshr e✝¹ (const? 1)) (LLVM.and (lshr e✝ (const? 1)) (const? 123)) ⊑
    add (lshr e✝¹ (const? 1)) (LLVM.and (lshr e✝ (const? 1)) (const? 123)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_add_or_fail_thm (e✝ e✝¹ : IntW 8) :
  LLVM.or (lshr e✝¹ (const? 1)) (add (lshr e✝ (const? 1)) (const? 123)) ⊑
    LLVM.or (lshr e✝¹ (const? 1)) (add (lshr e✝ (const? 1)) (const? 123) { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_add_xor_fail_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (lshr e✝¹ (const? 1)) (add (lshr e✝ (const? 1)) (const? 123)) ⊑
    LLVM.xor (lshr e✝¹ (const? 1)) (add (lshr e✝ (const? 1)) (const? 123) { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_and_fail_mismatch_shift_thm (e✝ e✝¹ : IntW 8) :
  LLVM.and (shl e✝¹ (const? 1)) (add (lshr e✝ (const? 1)) (const? 123)) ⊑
    LLVM.and (shl e✝¹ (const? 1)) (add (lshr e✝ (const? 1)) (const? 123) { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ashr_not_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.and (ashr e✝² e✝¹) (LLVM.xor (ashr e✝ e✝¹) (const? (-1))) ⊑
    ashr (LLVM.and e✝² (LLVM.xor e✝ (const? (-1)))) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ashr_not_commuted_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.and (LLVM.xor (ashr e✝² e✝¹) (const? (-1))) (ashr e✝ e✝¹) ⊑
    ashr (LLVM.and e✝ (LLVM.xor e✝² (const? (-1)))) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_ashr_not_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (ashr e✝² e✝¹) (LLVM.xor (ashr e✝ e✝¹) (const? (-1))) ⊑
    ashr (LLVM.or e✝² (LLVM.xor e✝ (const? (-1)))) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_ashr_not_commuted_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.or (LLVM.xor (ashr e✝² e✝¹) (const? (-1))) (ashr e✝ e✝¹) ⊑
    ashr (LLVM.or e✝ (LLVM.xor e✝² (const? (-1)))) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_ashr_not_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.xor (ashr e✝² e✝¹) (LLVM.xor (ashr e✝ e✝¹) (const? (-1))) ⊑
    LLVM.xor (ashr (LLVM.xor e✝ e✝²) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_ashr_not_commuted_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.xor (LLVM.xor (ashr e✝² e✝¹) (const? (-1))) (ashr e✝ e✝¹) ⊑
    LLVM.xor (ashr (LLVM.xor e✝² e✝) e✝¹) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_ashr_not_fail_lshr_ashr_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.xor (lshr e✝² e✝¹) (LLVM.xor (ashr e✝ e✝¹) (const? (-1))) ⊑
    LLVM.xor (LLVM.xor (ashr e✝ e✝¹) (lshr e✝² e✝¹)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_ashr_not_fail_ashr_lshr_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.xor (ashr e✝² e✝¹) (LLVM.xor (lshr e✝ e✝¹) (const? (-1))) ⊑
    LLVM.xor (LLVM.xor (lshr e✝ e✝¹) (ashr e✝² e✝¹)) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_ashr_not_fail_invalid_xor_constant_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.xor (ashr e✝² e✝¹) (LLVM.xor (ashr e✝ e✝¹) (const? (-2))) ⊑
    LLVM.xor (ashr (LLVM.xor e✝ e✝²) e✝¹) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


