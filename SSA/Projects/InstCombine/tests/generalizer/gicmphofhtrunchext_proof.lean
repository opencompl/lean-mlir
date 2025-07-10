
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphofhtrunchext_proof
theorem trunc_unsigned_nuw_proof.trunc_unsigned_nuw_thm_1 (e e_1 : IntW 16) :
  icmp IntPred.ult (trunc 8 e { «nuw» := true }) (trunc 8 e_1 { «nuw» := true }) ⊑ icmp IntPred.ult e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_unsigned_nsw_proof.trunc_unsigned_nsw_thm_1 (e e_1 : IntW 16) :
  icmp IntPred.ult (trunc 8 e { «nsw» := true }) (trunc 8 e_1 { «nsw» := true }) ⊑ icmp IntPred.ult e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_unsigned_both_proof.trunc_unsigned_both_thm_1 (e e_1 : IntW 16) :
  icmp IntPred.ult (trunc 8 e { «nsw» := true, «nuw» := true }) (trunc 8 e_1 { «nsw» := true, «nuw» := true }) ⊑
    icmp IntPred.ult e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_signed_nsw_proof.trunc_signed_nsw_thm_1 (e e_1 : IntW 16) :
  icmp IntPred.slt (trunc 8 e { «nsw» := true }) (trunc 8 e_1 { «nsw» := true }) ⊑ icmp IntPred.slt e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_signed_both_proof.trunc_signed_both_thm_1 (e e_1 : IntW 16) :
  icmp IntPred.slt (trunc 8 e { «nsw» := true, «nuw» := true }) (trunc 8 e_1 { «nsw» := true, «nuw» := true }) ⊑
    icmp IntPred.slt e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_equality_nuw_proof.trunc_equality_nuw_thm_1 (e e_1 : IntW 16) :
  icmp IntPred.eq (trunc 8 e { «nuw» := true }) (trunc 8 e_1 { «nuw» := true }) ⊑ icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_equality_nsw_proof.trunc_equality_nsw_thm_1 (e e_1 : IntW 16) :
  icmp IntPred.eq (trunc 8 e { «nsw» := true }) (trunc 8 e_1 { «nsw» := true }) ⊑ icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_equality_both_proof.trunc_equality_both_thm_1 (e e_1 : IntW 16) :
  icmp IntPred.eq (trunc 8 e { «nsw» := true, «nuw» := true }) (trunc 8 e_1 { «nsw» := true, «nuw» := true }) ⊑
    icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_unsigned_nuw_zext_proof.trunc_unsigned_nuw_zext_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPred.ult (trunc 16 e { «nuw» := true }) (zext 16 e_1) ⊑ icmp IntPred.ult e (zext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_unsigned_nsw_zext_proof.trunc_unsigned_nsw_zext_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPred.ult (trunc 16 e { «nsw» := true }) (zext 16 e_1) ⊑ icmp IntPred.ult e (zext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_unsigned_nsw_sext_proof.trunc_unsigned_nsw_sext_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPred.ult (trunc 16 e { «nsw» := true }) (sext 16 e_1) ⊑ icmp IntPred.ult e (sext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_signed_nsw_sext_proof.trunc_signed_nsw_sext_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPred.slt (trunc 16 e { «nsw» := true }) (sext 16 e_1) ⊑ icmp IntPred.slt e (sext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_signed_nsw_zext_proof.trunc_signed_nsw_zext_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPred.slt (trunc 16 e { «nsw» := true }) (zext 16 e_1) ⊑ icmp IntPred.slt e (zext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_equality_nuw_zext_proof.trunc_equality_nuw_zext_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPred.ne (trunc 16 e { «nuw» := true }) (zext 16 e_1) ⊑ icmp IntPred.ne e (zext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_equality_nsw_zext_proof.trunc_equality_nsw_zext_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPred.ne (trunc 16 e { «nsw» := true }) (zext 16 e_1) ⊑ icmp IntPred.ne e (zext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_equality_nsw_sext_proof.trunc_equality_nsw_sext_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPred.ne (trunc 16 e { «nsw» := true }) (sext 16 e_1) ⊑ icmp IntPred.ne e (sext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_equality_both_sext_proof.trunc_equality_both_sext_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPred.ne (trunc 16 e { «nsw» := true, «nuw» := true }) (sext 16 e_1) ⊑ icmp IntPred.ne e (sext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_eq1_proof.test_eq1_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  icmp IntPred.eq (trunc 8 e { «nsw» := true }) (trunc 8 e_1 { «nsw» := true }) ⊑
    icmp IntPred.eq e (sext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_eq2_proof.test_eq2_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  icmp IntPred.eq (trunc 8 e_1 { «nsw» := true }) (trunc 8 e { «nsw» := true }) ⊑
    icmp IntPred.eq e_1 (trunc 16 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_ult_proof.test_ult_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  icmp IntPred.ult (trunc 8 e { «nsw» := true }) (trunc 8 e_1 { «nsw» := true }) ⊑
    icmp IntPred.ult e (sext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_slt_proof.test_slt_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  icmp IntPred.slt (trunc 8 e { «nsw» := true }) (trunc 8 e_1 { «nsw» := true }) ⊑
    icmp IntPred.slt e (sext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_ult_nuw_proof.test_ult_nuw_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  icmp IntPred.ult (trunc 8 e { «nsw» := true, «nuw» := true }) (trunc 8 e_1 { «nsw» := true, «nuw» := true }) ⊑
    icmp IntPred.ult e (zext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_slt_nuw_proof.test_slt_nuw_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  icmp IntPred.slt (trunc 8 e { «nsw» := true, «nuw» := true }) (trunc 8 e_1 { «nsw» := true, «nuw» := true }) ⊑
    icmp IntPred.slt e (zext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
