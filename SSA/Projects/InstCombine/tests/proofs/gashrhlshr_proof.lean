
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gashrhlshr_proof
theorem ashr_known_pos_exact_thm (e✝ e✝¹ : IntW 8) :
  ashr (LLVM.and e✝¹ (const? 127)) e✝ ⊑ lshr (LLVM.and e✝¹ (const? 127)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_mul_times_3_div_2_thm (e✝ : IntW 32) :
  lshr (mul e✝ (const? 3) { «nsw» := true, «nuw» := true }) (const? 1) ⊑
    add e✝ (lshr e✝ (const? 1)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_mul_times_3_div_2_exact_thm (e✝ : IntW 32) :
  lshr (mul e✝ (const? 3) { «nsw» := true, «nuw» := false }) (const? 1) ⊑
    add e✝ (lshr e✝ (const? 1)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_mul_times_3_div_2_exact_2_thm (e✝ : IntW 32) :
  lshr (mul e✝ (const? 3) { «nsw» := false, «nuw» := true }) (const? 1) ⊑
    add e✝ (lshr e✝ (const? 1)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_mul_times_5_div_4_thm (e✝ : IntW 32) :
  lshr (mul e✝ (const? 5) { «nsw» := true, «nuw» := true }) (const? 2) ⊑
    add e✝ (lshr e✝ (const? 2)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_mul_times_5_div_4_exact_thm (e✝ : IntW 32) :
  lshr (mul e✝ (const? 5) { «nsw» := true, «nuw» := false }) (const? 2) ⊑
    add e✝ (lshr e✝ (const? 2)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_mul_times_5_div_4_exact_2_thm (e✝ : IntW 32) :
  lshr (mul e✝ (const? 5) { «nsw» := false, «nuw» := true }) (const? 2) ⊑
    add e✝ (lshr e✝ (const? 2)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_mul_times_3_div_2_thm (e✝ : IntW 32) :
  ashr (mul e✝ (const? 3) { «nsw» := true, «nuw» := true }) (const? 1) ⊑
    add e✝ (lshr e✝ (const? 1)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_mul_times_3_div_2_exact_thm (e✝ : IntW 32) :
  ashr (mul e✝ (const? 3) { «nsw» := true, «nuw» := false }) (const? 1) ⊑
    add e✝ (ashr e✝ (const? 1)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_mul_times_3_div_2_exact_2_thm (e✝ : IntW 32) :
  ashr (mul e✝ (const? 3) { «nsw» := true, «nuw» := false }) (const? 1) ⊑
    add e✝ (ashr e✝ (const? 1)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_mul_times_5_div_4_thm (e✝ : IntW 32) :
  ashr (mul e✝ (const? 5) { «nsw» := true, «nuw» := true }) (const? 2) ⊑
    add e✝ (lshr e✝ (const? 2)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_mul_times_5_div_4_exact_thm (e✝ : IntW 32) :
  ashr (mul e✝ (const? 5) { «nsw» := true, «nuw» := false }) (const? 2) ⊑
    add e✝ (ashr e✝ (const? 2)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_mul_times_5_div_4_exact_2_thm (e✝ : IntW 32) :
  ashr (mul e✝ (const? 5) { «nsw» := true, «nuw» := false }) (const? 2) ⊑
    add e✝ (ashr e✝ (const? 2)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lsb_mask_sign_zext_wrong_cst2_thm (e✝ : IntW 32) :
  lshr (LLVM.and (add e✝ (const? (-1))) (LLVM.xor e✝ (const? 2))) (const? 31) ⊑
    lshr (LLVM.and (add e✝ (const? (-1))) e✝) (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lsb_mask_sign_sext_wrong_cst2_thm (e✝ : IntW 32) :
  ashr (LLVM.and (add e✝ (const? (-1))) (LLVM.xor e✝ (const? 2))) (const? 31) ⊑
    ashr (LLVM.and (add e✝ (const? (-1))) e✝) (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


