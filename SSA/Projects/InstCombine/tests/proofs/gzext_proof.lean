
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gzext_proof
theorem test_sext_zext_thm : ∀ (e : IntW 16), sext 64 (zext 32 e) ⊑ zext 64 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_xor_zext_sandwich_thm :
  ∀ (e : IntW 1), zext 64 (LLVM.xor (zext 32 e) (const? 1)) ⊑ zext 64 (LLVM.xor e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_zext_apint1_thm : ∀ (e : IntW 77), sext 1024 (zext 533 e) ⊑ zext 1024 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_zext_apint2_thm : ∀ (e : IntW 11), sext 47 (zext 39 e) ⊑ zext 47 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zext_nneg_flag_drop_thm :
  ∀ (e : IntW 16) (e_1 : IntW 8),
    LLVM.or (LLVM.or (zext 16 (LLVM.and e_1 (const? 127))) e) (const? 128) ⊑
      LLVM.or (LLVM.or e (zext 16 e_1)) (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zext_nneg_redundant_and_thm : ∀ (e : IntW 8), LLVM.and (zext 32 e) (const? 127) ⊑ zext 32 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zext_nneg_signbit_extract_thm : ∀ (e : IntW 32), lshr (zext 64 e) (const? 31) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zext_nneg_i1_thm : ∀ (e : IntW 1), zext 32 e ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


