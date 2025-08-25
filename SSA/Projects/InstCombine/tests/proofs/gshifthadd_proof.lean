
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gshifthadd_proof
theorem shl_C1_add_A_C2_i32_thm (e : IntW 16) :
  shl (const? 32 6) (add (zext 32 e) (const? 32 5)) ⊑ shl (const? 32 192) (zext 32 e { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ashr_C1_add_A_C2_i32_thm (e : IntW 32) :
  ashr (const? 32 6) (add (LLVM.and e (const? 32 65535)) (const? 32 5)) ⊑ const? 32 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_C1_add_A_C2_i32_thm (e : IntW 32) :
  shl (const? 32 6) (add (LLVM.and e (const? 32 65535)) (const? 32 5)) ⊑
    shl (const? 32 192) (LLVM.and e (const? 32 65535)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_add_nuw_thm (e : IntW 32) :
  shl (const? 32 6) (add e (const? 32 5) { «nsw» := false, «nuw» := true }) ⊑ shl (const? 32 192) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_nuw_add_nuw_thm (e : IntW 32) :
  shl (const? 32 1) (add e (const? 32 1) { «nsw» := false, «nuw» := true }) { «nsw» := false, «nuw» := true } ⊑
    shl (const? 32 2) e { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_nsw_add_nuw_thm (e : IntW 32) :
  shl (const? 32 (-1)) (add e (const? 32 1) { «nsw» := false, «nuw» := true }) { «nsw» := true, «nuw» := false } ⊑
    shl (const? 32 (-2)) e { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_exact_add_nuw_thm (e : IntW 32) :
  lshr (const? 32 4) (add e (const? 32 1) { «nsw» := false, «nuw» := true }) { «exact» := true } ⊑
    lshr (const? 32 2) e { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ashr_exact_add_nuw_thm (e : IntW 32) :
  ashr (const? 32 (-4)) (add e (const? 32 1) { «nsw» := false, «nuw» := true }) { «exact» := true } ⊑
    ashr (const? 32 (-2)) e { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_exact_add_negative_shift_positive_thm (e : IntW 32) :
  lshr (const? 32 2) (add e (const? 32 (-1))) { «exact» := true } ⊑ lshr (const? 32 4) e { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ashr_exact_add_negative_shift_negative_thm (e : IntW 32) :
  ashr (const? 32 (-2)) (add e (const? 32 (-1))) { «exact» := true } ⊑
    ashr (const? 32 (-4)) e { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_nsw_add_negative_thm (e : IntW 32) :
  shl (const? 32 2) (add e (const? 32 (-1))) { «nsw» := true, «nuw» := false } ⊑
    shl (const? 32 1) e { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_nsw_add_negative_invalid_constant3_thm (e : IntW 4) :
  shl (const? 4 2) (add e (const? 4 (-8))) { «nsw» := true, «nuw» := false } ⊑
    shl (const? 4 2) (LLVM.xor e (const? 4 (-8))) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_2_add_zext_basic_thm (e e_1 : IntW 1) :
  lshr (add (zext 2 e_1) (zext 2 e)) (const? 2 1) ⊑ zext 2 (LLVM.and e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ashr_2_add_zext_basic_thm (e e_1 : IntW 1) :
  ashr (add (zext 2 e_1) (zext 2 e)) (const? 2 1) ⊑
    ashr (add (zext 2 e_1) (zext 2 e) { «nsw» := false, «nuw» := true }) (const? 2 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_16_add_zext_basic_thm (e e_1 : IntW 16) :
  lshr (add (zext 32 e_1) (zext 32 e)) (const? 32 16) ⊑
    zext 32 (icmp IntPred.ugt e (LLVM.xor e_1 (const? 16 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_16_add_zext_basic_multiuse_thm (e e_1 : IntW 16) :
  LLVM.or (lshr (add (zext 32 e_1) (zext 32 e)) (const? 32 16)) (zext 32 e_1) ⊑
    LLVM.or (lshr (add (zext 32 e_1) (zext 32 e) { «nsw» := true, «nuw» := true }) (const? 32 16))
      (zext 32 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_16_add_known_16_leading_zeroes_thm (e e_1 : IntW 32) :
  lshr (add (LLVM.and e_1 (const? 32 65535)) (LLVM.and e (const? 32 65535))) (const? 32 16) ⊑
    lshr (add (LLVM.and e_1 (const? 32 65535)) (LLVM.and e (const? 32 65535)) { «nsw» := true, «nuw» := true })
      (const? 32 16) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_16_add_not_known_16_leading_zeroes_thm (e e_1 : IntW 32) :
  lshr (add (LLVM.and e_1 (const? 32 131071)) (LLVM.and e (const? 32 65535))) (const? 32 16) ⊑
    lshr (add (LLVM.and e_1 (const? 32 131071)) (LLVM.and e (const? 32 65535)) { «nsw» := true, «nuw» := true })
      (const? 32 16) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_32_add_zext_basic_thm (e e_1 : IntW 32) :
  lshr (add (zext 64 e_1) (zext 64 e)) (const? 64 32) ⊑
    zext 64 (icmp IntPred.ugt e (LLVM.xor e_1 (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_32_add_zext_basic_multiuse_thm (e e_1 : IntW 32) :
  LLVM.or (lshr (add (zext 64 e_1) (zext 64 e)) (const? 64 32)) (zext 64 e) ⊑
    LLVM.or (lshr (add (zext 64 e_1) (zext 64 e) { «nsw» := true, «nuw» := true }) (const? 64 32)) (zext 64 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_31_i32_add_zext_basic_thm (e e_1 : IntW 32) :
  lshr (add (zext 64 e_1) (zext 64 e)) (const? 64 31) ⊑
    lshr (add (zext 64 e_1) (zext 64 e) { «nsw» := true, «nuw» := true }) (const? 64 31) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_33_i32_add_zext_basic_thm (e e_1 : IntW 32) : lshr (add (zext 64 e_1) (zext 64 e)) (const? 64 33) ⊑ const? 64 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_16_to_64_add_zext_basic_thm (e e_1 : IntW 16) :
  lshr (add (zext 64 e_1) (zext 64 e)) (const? 64 16) ⊑
    zext 64 (icmp IntPred.ugt e (LLVM.xor e_1 (const? 16 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_32_add_known_32_leading_zeroes_thm (e e_1 : IntW 64) :
  lshr (add (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295))) (const? 64 32) ⊑
    lshr
      (add (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295)) { «nsw» := true, «nuw» := true })
      (const? 64 32) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_32_add_not_known_32_leading_zeroes_thm (e e_1 : IntW 64) :
  lshr (add (LLVM.and e_1 (const? 64 8589934591)) (LLVM.and e (const? 64 4294967295))) (const? 64 32) ⊑
    lshr
      (add (LLVM.and e_1 (const? 64 8589934591)) (LLVM.and e (const? 64 4294967295)) { «nsw» := true, «nuw» := true })
      (const? 64 32) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ashr_16_add_zext_basic_thm (e e_1 : IntW 16) :
  lshr (add (zext 32 e_1) (zext 32 e)) (const? 32 16) ⊑
    zext 32 (icmp IntPred.ugt e (LLVM.xor e_1 (const? 16 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ashr_32_add_zext_basic_thm (e e_1 : IntW 32) :
  ashr (add (zext 64 e_1) (zext 64 e)) (const? 64 32) ⊑
    zext 64 (icmp IntPred.ugt e (LLVM.xor e_1 (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ashr_16_to_64_add_zext_basic_thm (e e_1 : IntW 16) :
  ashr (add (zext 64 e_1) (zext 64 e)) (const? 64 16) ⊑
    zext 64 (icmp IntPred.ugt e (LLVM.xor e_1 (const? 16 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem lshr_32_add_zext_trunc_thm (e e_1 : IntW 32) :
  add (trunc 32 (add (zext 64 e_1) (zext 64 e))) (trunc 32 (lshr (add (zext 64 e_1) (zext 64 e)) (const? 64 32))) ⊑
    add (add e_1 e) (zext 32 (icmp IntPred.ult (add e_1 e) e_1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_fold_or_disjoint_cnt_thm (e : IntW 8) :
  shl (const? 8 2) (LLVM.or e (const? 8 3) { «disjoint» := true }) ⊑ shl (const? 8 16) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
