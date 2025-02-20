
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gicmphofhtrunchext_proof
theorem trunc_unsigned_nuw_thm (e e_1 : IntW 16) :
  icmp IntPredicate.ult (trunc 8 e_1 { «nsw» := false, «nuw» := true }) (trunc 8 e { «nsw» := false, «nuw» := true }) ⊑
    icmp IntPredicate.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_unsigned_nsw_thm (e e_1 : IntW 16) :
  icmp IntPredicate.ult (trunc 8 e_1 { «nsw» := true, «nuw» := false }) (trunc 8 e { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_unsigned_both_thm (e e_1 : IntW 16) :
  icmp IntPredicate.ult (trunc 8 e_1 { «nsw» := true, «nuw» := true }) (trunc 8 e { «nsw» := true, «nuw» := true }) ⊑
    icmp IntPredicate.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_signed_nsw_thm (e e_1 : IntW 16) :
  icmp IntPredicate.slt (trunc 8 e_1 { «nsw» := true, «nuw» := false }) (trunc 8 e { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_signed_both_thm (e e_1 : IntW 16) :
  icmp IntPredicate.slt (trunc 8 e_1 { «nsw» := true, «nuw» := true }) (trunc 8 e { «nsw» := true, «nuw» := true }) ⊑
    icmp IntPredicate.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_equality_nuw_thm (e e_1 : IntW 16) :
  icmp IntPredicate.eq (trunc 8 e_1 { «nsw» := false, «nuw» := true }) (trunc 8 e { «nsw» := false, «nuw» := true }) ⊑
    icmp IntPredicate.eq e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_equality_nsw_thm (e e_1 : IntW 16) :
  icmp IntPredicate.eq (trunc 8 e_1 { «nsw» := true, «nuw» := false }) (trunc 8 e { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.eq e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_equality_both_thm (e e_1 : IntW 16) :
  icmp IntPredicate.eq (trunc 8 e_1 { «nsw» := true, «nuw» := true }) (trunc 8 e { «nsw» := true, «nuw» := true }) ⊑
    icmp IntPredicate.eq e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_unsigned_nuw_zext_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ult (trunc 16 e_1 { «nsw» := false, «nuw» := true }) (zext 16 e) ⊑
    icmp IntPredicate.ult e_1 (zext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_unsigned_nsw_zext_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ult (trunc 16 e_1 { «nsw» := true, «nuw» := false }) (zext 16 e) ⊑
    icmp IntPredicate.ult e_1 (zext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_unsigned_nsw_sext_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ult (trunc 16 e_1 { «nsw» := true, «nuw» := false }) (sext 16 e) ⊑
    icmp IntPredicate.ult e_1 (sext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_signed_nsw_sext_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.slt (trunc 16 e_1 { «nsw» := true, «nuw» := false }) (sext 16 e) ⊑
    icmp IntPredicate.slt e_1 (sext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_signed_nsw_zext_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.slt (trunc 16 e_1 { «nsw» := true, «nuw» := false }) (zext 16 e) ⊑
    icmp IntPredicate.slt e_1 (zext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_equality_nuw_zext_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ne (trunc 16 e_1 { «nsw» := false, «nuw» := true }) (zext 16 e) ⊑
    icmp IntPredicate.ne e_1 (zext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_equality_nsw_zext_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ne (trunc 16 e_1 { «nsw» := true, «nuw» := false }) (zext 16 e) ⊑
    icmp IntPredicate.ne e_1 (zext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_equality_nsw_sext_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ne (trunc 16 e_1 { «nsw» := true, «nuw» := false }) (sext 16 e) ⊑
    icmp IntPredicate.ne e_1 (sext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_equality_both_sext_thm (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPredicate.ne (trunc 16 e_1 { «nsw» := true, «nuw» := true }) (sext 16 e) ⊑
    icmp IntPredicate.ne e_1 (sext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_eq1_thm (e : IntW 16) (e_1 : IntW 32) :
  icmp IntPredicate.eq (trunc 8 e_1 { «nsw» := true, «nuw» := false }) (trunc 8 e { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.eq e_1 (sext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_eq2_thm (e : IntW 32) (e_1 : IntW 16) :
  icmp IntPredicate.eq (trunc 8 e_1 { «nsw» := true, «nuw» := false }) (trunc 8 e { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.eq e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_ult_thm (e : IntW 16) (e_1 : IntW 32) :
  icmp IntPredicate.ult (trunc 8 e_1 { «nsw» := true, «nuw» := false }) (trunc 8 e { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.ult e_1 (sext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_slt_thm (e : IntW 16) (e_1 : IntW 32) :
  icmp IntPredicate.slt (trunc 8 e_1 { «nsw» := true, «nuw» := false }) (trunc 8 e { «nsw» := true, «nuw» := false }) ⊑
    icmp IntPredicate.slt e_1 (sext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_ult_nuw_thm (e : IntW 16) (e_1 : IntW 32) :
  icmp IntPredicate.ult (trunc 8 e_1 { «nsw» := true, «nuw» := true }) (trunc 8 e { «nsw» := true, «nuw» := true }) ⊑
    icmp IntPredicate.ult e_1 (zext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_slt_nuw_thm (e : IntW 16) (e_1 : IntW 32) :
  icmp IntPredicate.slt (trunc 8 e_1 { «nsw» := true, «nuw» := true }) (trunc 8 e { «nsw» := true, «nuw» := true }) ⊑
    icmp IntPredicate.slt e_1 (zext 32 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
