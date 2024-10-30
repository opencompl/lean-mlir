
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthadd_proof
theorem shl_C1_add_A_C2_i32_thm :
  ∀ (e : IntW 16), shl (const? 6) (add (zext 32 e) (const? 5)) ⊑ shl (const? 192) (zext 32 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_C1_add_A_C2_i32_thm : ∀ (e : IntW 32), ashr (const? 6) (add (LLVM.and e (const? 65535)) (const? 5)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_C1_add_A_C2_i32_thm :
  ∀ (e : IntW 32),
    shl (const? 6) (add (LLVM.and e (const? 65535)) (const? 5)) ⊑ shl (const? 192) (LLVM.and e (const? 65535)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_nuw_thm :
  ∀ (e : IntW 32), shl (const? 6) (add e (const? 5) { «nsw» := false, «nuw» := true }) ⊑ shl (const? 192) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nuw_add_nuw_thm :
  ∀ (e : IntW 32),
    shl (const? 1) (add e (const? 1) { «nsw» := false, «nuw» := true }) { «nsw» := false, «nuw» := true } ⊑
      shl (const? 2) e { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_add_nuw_thm :
  ∀ (e : IntW 32),
    shl (const? (-1)) (add e (const? 1) { «nsw» := false, «nuw» := true }) { «nsw» := true, «nuw» := false } ⊑
      shl (const? (-2)) e { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_exact_add_nuw_thm :
  ∀ (e : IntW 32), lshr (const? 4) (add e (const? 1) { «nsw» := false, «nuw» := true }) ⊑ lshr (const? 2) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_exact_add_nuw_thm :
  ∀ (e : IntW 32),
    ashr (const? (-4)) (add e (const? 1) { «nsw» := false, «nuw» := true }) ⊑ ashr (const? (-2)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_exact_add_negative_shift_positive_thm : ∀ (e : IntW 32), lshr (const? 2) (add e (const? (-1))) ⊑ lshr (const? 4) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_exact_add_negative_shift_negative_thm : ∀ (e : IntW 32), ashr (const? (-2)) (add e (const? (-1))) ⊑ ashr (const? (-4)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_add_negative_thm :
  ∀ (e : IntW 32),
    shl (const? 2) (add e (const? (-1))) { «nsw» := true, «nuw» := false } ⊑
      shl (const? 1) e { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_add_negative_invalid_constant3_thm :
  ∀ (e : IntW 4),
    shl (const? 2) (add e (const? (-8))) { «nsw» := true, «nuw» := false } ⊑
      shl (const? 2) (LLVM.xor e (const? (-8))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_2_add_zext_basic_thm :
  ∀ (e e_1 : IntW 1), lshr (add (zext 2 e_1) (zext 2 e)) (const? 1) ⊑ zext 2 (LLVM.and e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_2_add_zext_basic_thm :
  ∀ (e e_1 : IntW 1),
    ashr (add (zext 2 e_1) (zext 2 e)) (const? 1) ⊑
      ashr (add (zext 2 e_1) (zext 2 e) { «nsw» := false, «nuw» := true }) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_16_add_zext_basic_multiuse_thm :
  ∀ (e e_1 : IntW 16),
    LLVM.or (lshr (add (zext 32 e_1) (zext 32 e)) (const? 16)) (zext 32 e_1) ⊑
      LLVM.or (lshr (add (zext 32 e_1) (zext 32 e) { «nsw» := true, «nuw» := true }) (const? 16)) (zext 32 e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_16_add_known_16_leading_zeroes_thm :
  ∀ (e e_1 : IntW 32),
    lshr (add (LLVM.and e_1 (const? 65535)) (LLVM.and e (const? 65535))) (const? 16) ⊑
      lshr (add (LLVM.and e_1 (const? 65535)) (LLVM.and e (const? 65535)) { «nsw» := true, «nuw» := true })
        (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_16_add_not_known_16_leading_zeroes_thm :
  ∀ (e e_1 : IntW 32),
    lshr (add (LLVM.and e_1 (const? 131071)) (LLVM.and e (const? 65535))) (const? 16) ⊑
      lshr (add (LLVM.and e_1 (const? 131071)) (LLVM.and e (const? 65535)) { «nsw» := true, «nuw» := true })
        (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_32_add_zext_basic_multiuse_thm :
  ∀ (e e_1 : IntW 32),
    LLVM.or (lshr (add (zext 64 e_1) (zext 64 e)) (const? 32)) (zext 64 e) ⊑
      LLVM.or (lshr (add (zext 64 e_1) (zext 64 e) { «nsw» := true, «nuw» := true }) (const? 32)) (zext 64 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_31_i32_add_zext_basic_thm :
  ∀ (e e_1 : IntW 32),
    lshr (add (zext 64 e_1) (zext 64 e)) (const? 31) ⊑
      lshr (add (zext 64 e_1) (zext 64 e) { «nsw» := true, «nuw» := true }) (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_33_i32_add_zext_basic_thm : ∀ (e e_1 : IntW 32), lshr (add (zext 64 e_1) (zext 64 e)) (const? 33) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_32_add_known_32_leading_zeroes_thm :
  ∀ (e e_1 : IntW 64),
    lshr (add (LLVM.and e_1 (const? 4294967295)) (LLVM.and e (const? 4294967295))) (const? 32) ⊑
      lshr (add (LLVM.and e_1 (const? 4294967295)) (LLVM.and e (const? 4294967295)) { «nsw» := true, «nuw» := true })
        (const? 32) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_32_add_not_known_32_leading_zeroes_thm :
  ∀ (e e_1 : IntW 64),
    lshr (add (LLVM.and e_1 (const? 8589934591)) (LLVM.and e (const? 4294967295))) (const? 32) ⊑
      lshr (add (LLVM.and e_1 (const? 8589934591)) (LLVM.and e (const? 4294967295)) { «nsw» := true, «nuw» := true })
        (const? 32) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_fold_or_disjoint_cnt_thm : ∀ (e : IntW 8), shl (const? 2) (LLVM.or e (const? 3)) ⊑ shl (const? 16) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry

