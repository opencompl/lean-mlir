
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphandhshift_proof
theorem icmp_eq_and_pow2_shl1_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (shl (const? 32 1) e) (const? 32 16)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ne e (const? 32 4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_ne_and_pow2_shl1_thm (e : IntW 32) :
  zext 32 (icmp IntPred.ne (LLVM.and (shl (const? 32 1) e) (const? 32 16)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.eq e (const? 32 4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and_pow2_shl_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (shl (const? 32 2) e) (const? 32 16)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ne e (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_ne_and_pow2_shl_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.ne (LLVM.and (shl (const? 32 2) e) (const? 32 16)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.eq e (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and_pow2_shl_pow2_negative1_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (shl (const? 32 11) e) (const? 32 16)) (const? 32 0)) ⊑
    LLVM.xor (LLVM.and (lshr (shl (const? 32 11) e) (const? 32 4)) (const? 32 1)) (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and_pow2_shl_pow2_negative2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (shl (const? 32 2) e) (const? 32 14)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ugt e (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and_pow2_shl_pow2_negative3_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (shl (const? 32 32) e) (const? 32 16)) (const? 32 0)) ⊑ const? 32 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and_pow2_minus1_shl1_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (shl (const? 32 1) e) (const? 32 15)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ugt e (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_ne_and_pow2_minus1_shl1_thm (e : IntW 32) :
  zext 32 (icmp IntPred.ne (LLVM.and (shl (const? 32 1) e) (const? 32 15)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ult e (const? 32 4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and_pow2_minus1_shl_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (shl (const? 32 2) e) (const? 32 15)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ugt e (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_ne_and_pow2_minus1_shl_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.ne (LLVM.and (shl (const? 32 2) e) (const? 32 15)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ult e (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and_pow2_minus1_shl1_negative2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (shl (const? 32 32) e) (const? 32 15)) (const? 32 0)) ⊑ const? 32 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and1_lshr_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (lshr (const? 32 8) e) (const? 32 1)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ne e (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_ne_and1_lshr_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (lshr (const? 32 8) e) (const? 32 1)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ne e (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and_pow2_lshr_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (lshr (const? 32 8) e) (const? 32 4)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ne e (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and_pow2_lshr_pow2_case2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (lshr (const? 32 4) e) (const? 32 8)) (const? 32 0)) ⊑ const? 32 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_ne_and_pow2_lshr_pow2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (lshr (const? 32 8) e) (const? 32 4)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ne e (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_ne_and_pow2_lshr_pow2_case2_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (lshr (const? 32 4) e) (const? 32 8)) (const? 32 0)) ⊑ const? 32 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem icmp_eq_and1_lshr_pow2_minus_one_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and (lshr (const? 32 7) e) (const? 32 1)) (const? 32 0)) ⊑
    zext 32 (icmp IntPred.ugt e (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem eq_and_shl_one_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.and (shl (const? 8 1) e_1) e) (shl (const? 8 1) e_1) ⊑
    icmp IntPred.ne (LLVM.and (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) e) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ne_and_lshr_minval_thm (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.and (mul e_1 e_1) (lshr (const? 8 (-128)) e)) (lshr (const? 8 (-128)) e) ⊑
    icmp IntPred.eq (LLVM.and (mul e_1 e_1) (lshr (const? 8 (-128)) e { «exact» := true })) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_and_shl_one_thm (e e_1 : IntW 8) :
  icmp IntPred.slt (LLVM.and e_1 (shl (const? 8 1) e)) (shl (const? 8 1) e) ⊑
    icmp IntPred.slt (LLVM.and e_1 (shl (const? 8 1) e { «nsw» := false, «nuw» := true }))
      (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem fold_eq_lhs_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.and (shl (const? 8 (-1)) e_1) e) (const? 8 0) ⊑
    icmp IntPred.eq (lshr e e_1) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem fold_eq_lhs_fail_eq_nonzero_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.and (shl (const? 8 (-1)) e_1) e) (const? 8 1) ⊑
    icmp IntPred.eq (LLVM.and (shl (const? 8 (-1)) e_1 { «nsw» := true, «nuw» := false }) e) (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem fold_ne_rhs_thm (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.and (LLVM.xor e_1 (const? 8 123)) (shl (const? 8 (-1)) e)) (const? 8 0) ⊑
    icmp IntPred.ne (lshr (LLVM.xor e_1 (const? 8 123)) e) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem fold_ne_rhs_fail_shift_not_1s_thm (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.and (LLVM.xor e_1 (const? 8 123)) (shl (const? 8 (-2)) e)) (const? 8 0) ⊑
    icmp IntPred.ne (LLVM.and (LLVM.xor e_1 (const? 8 122)) (shl (const? 8 (-2)) e)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_shr_and_1_ne_0_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.and (lshr e_1 e) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e_1 (shl (const? 32 1) e { «nsw» := false, «nuw» := true })) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_shr_and_1_ne_0_samesign_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.and (lshr e_1 e) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e_1 (shl (const? 32 1) e { «nsw» := false, «nuw» := true })) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_const_shr_and_1_ne_0_thm (e : IntW 32) :
  icmp IntPred.ne (LLVM.and (lshr (const? 32 42) e) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and (shl (const? 32 1) e { «nsw» := false, «nuw» := true }) (const? 32 42))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_not_const_shr_and_1_ne_0_thm (e : IntW 32) :
  icmp IntPred.eq (LLVM.and (lshr (const? 32 42) e) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and (shl (const? 32 1) e { «nsw» := false, «nuw» := true }) (const? 32 42))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_const_shr_exact_and_1_ne_0_thm (e : IntW 32) :
  icmp IntPred.ne (LLVM.and (lshr (const? 32 42) e { «exact» := true }) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and (shl (const? 32 1) e { «nsw» := false, «nuw» := true }) (const? 32 42))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_const_shr_and_1_ne_0_i1_negative_thm (e : IntW 1) :
  icmp IntPred.ne (LLVM.and (lshr (const? 1 1) e) (const? 1 1)) (const? 1 0) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
