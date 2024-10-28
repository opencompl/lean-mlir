
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gtrunc_proof
theorem test5_thm : ∀ (e : IntW 32), trunc 32 (lshr (zext 128 e) (const? 16)) ⊑ lshr e (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm : ∀ (e : IntW 64), trunc 32 (lshr (zext 128 e) (const? 32)) ⊑ trunc 32 (lshr e (const? 32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_mul_sign_bits_thm :
  ∀ (e e_1 : IntW 8),
    trunc 16 (ashr (mul (sext 32 e_1) (sext 32 e)) (const? 3)) ⊑
      ashr (mul (sext 16 e_1) (sext 16 e) { «nsw» := true, «nuw» := false }) (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_mul_thm :
  ∀ (e e_1 : IntW 8),
    trunc 16 (ashr (mul (sext 20 e_1) (sext 20 e)) (const? 8)) ⊑
      ashr (mul (sext 16 e_1) (sext 16 e) { «nsw» := true, «nuw» := false }) (const? 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_ashr_thm :
  ∀ (e : IntW 32),
    trunc 32 (ashr (LLVM.or (zext 36 e) (const? (-2147483648))) (const? 8)) ⊑
      LLVM.or (lshr e (const? 8)) (const? (-8388608)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm : ∀ (e : IntW 64), trunc 92 (lshr (zext 128 e) (const? 32)) ⊑ zext 92 (lshr e (const? 32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm :
  ∀ (e e_1 : IntW 32),
    trunc 64 (LLVM.or (shl (zext 128 e_1) (const? 32)) (zext 128 e)) ⊑
      LLVM.or (shl (zext 64 e_1) (const? 32) { «nsw» := false, «nuw» := true }) (zext 64 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm : ∀ (e : IntW 32), trunc 8 (LLVM.and e (const? 42)) ⊑ LLVM.and (trunc 8 e) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11_thm :
  ∀ (e e_1 : IntW 32),
    trunc 64 (shl (zext 128 e_1) (LLVM.and (zext 128 e) (const? 31))) ⊑
      shl (zext 64 e_1) (zext 64 (LLVM.and e (const? 31))) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_thm :
  ∀ (e e_1 : IntW 32),
    trunc 64 (lshr (zext 128 e_1) (LLVM.and (zext 128 e) (const? 31))) ⊑
      lshr (zext 64 e_1) (zext 64 (LLVM.and e (const? 31))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm :
  ∀ (e e_1 : IntW 32),
    trunc 64 (ashr (sext 128 e_1) (LLVM.and (zext 128 e) (const? 31))) ⊑
      ashr (sext 64 e_1) (zext 64 (LLVM.and e (const? 31))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_31_i32_i64_thm : ∀ (e : IntW 64), trunc 32 (shl e (const? 31)) ⊑ shl (trunc 32 e) (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_nsw_31_i32_i64_thm :
  ∀ (e : IntW 64),
    trunc 32 (shl e (const? 31) { «nsw» := true, «nuw» := false }) ⊑ shl (trunc 32 e) (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_nuw_31_i32_i64_thm :
  ∀ (e : IntW 64),
    trunc 32 (shl e (const? 31) { «nsw» := false, «nuw» := true }) ⊑ shl (trunc 32 e) (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_nsw_nuw_31_i32_i64_thm :
  ∀ (e : IntW 64), trunc 32 (shl e (const? 31) { «nsw» := true, «nuw» := true }) ⊑ shl (trunc 32 e) (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_15_i16_i64_thm : ∀ (e : IntW 64), trunc 16 (shl e (const? 15)) ⊑ shl (trunc 16 e) (const? 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_15_i16_i32_thm : ∀ (e : IntW 32), trunc 16 (shl e (const? 15)) ⊑ shl (trunc 16 e) (const? 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_7_i8_i64_thm : ∀ (e : IntW 64), trunc 8 (shl e (const? 7)) ⊑ shl (trunc 8 e) (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_1_i32_i64_thm : ∀ (e : IntW 64), trunc 32 (shl e (const? 1)) ⊑ shl (trunc 32 e) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_16_i32_i64_thm : ∀ (e : IntW 64), trunc 32 (shl e (const? 16)) ⊑ shl (trunc 32 e) (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_33_i32_i64_thm : ∀ (e : IntW 64), trunc 32 (shl e (const? 33)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_32_i32_i64_thm : ∀ (e : IntW 64), trunc 32 (shl e (const? 32)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_lshr_infloop_thm :
  ∀ (e : IntW 64),
    trunc 32 (shl (lshr e (const? 1)) (const? 2)) ⊑ LLVM.and (shl (trunc 32 e) (const? 1)) (const? (-4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_ashr_infloop_thm :
  ∀ (e : IntW 64),
    trunc 32 (shl (ashr e (const? 3)) (const? 2)) ⊑ LLVM.and (trunc 32 (lshr e (const? 1))) (const? (-4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_shl_infloop_thm :
  ∀ (e : IntW 64), trunc 32 (shl (shl e (const? 1)) (const? 2)) ⊑ shl (trunc 32 e) (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_lshr_var_thm :
  ∀ (e e_1 : IntW 64), trunc 32 (shl (lshr e_1 e) (const? 2)) ⊑ shl (trunc 32 (lshr e_1 e)) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_ashr_var_thm :
  ∀ (e e_1 : IntW 64), trunc 32 (shl (ashr e_1 e) (const? 2)) ⊑ shl (trunc 32 (ashr e_1 e)) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_shl_shl_var_thm :
  ∀ (e e_1 : IntW 64), trunc 32 (shl (shl e_1 e) (const? 2)) ⊑ shl (trunc 32 (shl e_1 e)) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem drop_nsw_trunc_thm :
  ∀ (e e_1 : IntW 16), trunc 8 (LLVM.and (LLVM.and e_1 (const? 255)) e) ⊑ trunc 8 (LLVM.and e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem drop_nuw_trunc_thm :
  ∀ (e e_1 : IntW 16), trunc 8 (LLVM.and (LLVM.and e_1 (const? 255)) e) ⊑ trunc 8 (LLVM.and e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem drop_both_trunc_thm :
  ∀ (e e_1 : IntW 16), trunc 8 (LLVM.and (LLVM.and e_1 (const? 255)) e) ⊑ trunc 8 (LLVM.and e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


