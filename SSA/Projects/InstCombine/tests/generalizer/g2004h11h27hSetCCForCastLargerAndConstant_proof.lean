
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section g2004h11h27hSetCCForCastLargerAndConstant_proof
theorem lt_signed_to_large_unsigned_proof.lt_signed_to_large_unsigned_thm_1 (e : IntW 8) :
  icmp IntPred.ult (sext 32 e) (const? 32 1024) ⊑ icmp IntPred.sgt e (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_signed_to_large_signed_proof.lt_signed_to_large_signed_thm_1 (e : IntW 8) :
  icmp IntPred.slt (sext 32 e) (const? 32 1024) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_signed_to_large_negative_proof.lt_signed_to_large_negative_thm_1 (e : IntW 8) :
  icmp IntPred.slt (sext 32 e) (const? 32 (-1024)) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_signed_to_small_unsigned_proof.lt_signed_to_small_unsigned_thm_1 (e : IntW 8) :
  icmp IntPred.ult (sext 32 e) (const? 32 17) ⊑ icmp IntPred.ult e (const? 8 17) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_signed_to_small_signed_proof.lt_signed_to_small_signed_thm_1 (e : IntW 8) :
  icmp IntPred.slt (sext 32 e) (const? 32 17) ⊑ icmp IntPred.slt e (const? 8 17) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_signed_to_small_negative_proof.lt_signed_to_small_negative_thm_1 (e : IntW 8) :
  icmp IntPred.slt (sext 32 e) (const? 32 (-17)) ⊑ icmp IntPred.slt e (const? 8 (-17)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_unsigned_to_large_unsigned_proof.lt_unsigned_to_large_unsigned_thm_1 (e : IntW 8) :
  icmp IntPred.ult (zext 32 e) (const? 32 1024) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_unsigned_to_large_signed_proof.lt_unsigned_to_large_signed_thm_1 (e : IntW 8) :
  icmp IntPred.slt (zext 32 e) (const? 32 1024) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_unsigned_to_large_negative_proof.lt_unsigned_to_large_negative_thm_1 (e : IntW 8) :
  icmp IntPred.slt (zext 32 e) (const? 32 (-1024)) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_unsigned_to_small_unsigned_proof.lt_unsigned_to_small_unsigned_thm_1 (e : IntW 8) :
  icmp IntPred.ult (zext 32 e) (const? 32 17) ⊑ icmp IntPred.ult e (const? 8 17) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_unsigned_to_small_signed_proof.lt_unsigned_to_small_signed_thm_1 (e : IntW 8) :
  icmp IntPred.slt (zext 32 e) (const? 32 17) ⊑ icmp IntPred.ult e (const? 8 17) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lt_unsigned_to_small_negative_proof.lt_unsigned_to_small_negative_thm_1 (e : IntW 8) :
  icmp IntPred.slt (zext 32 e) (const? 32 (-17)) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_signed_to_large_unsigned_proof.gt_signed_to_large_unsigned_thm_1 (e : IntW 8) :
  icmp IntPred.ugt (sext 32 e) (const? 32 1024) ⊑ icmp IntPred.slt e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_signed_to_large_signed_proof.gt_signed_to_large_signed_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (sext 32 e) (const? 32 1024) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_signed_to_large_negative_proof.gt_signed_to_large_negative_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (sext 32 e) (const? 32 (-1024)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_signed_to_small_unsigned_proof.gt_signed_to_small_unsigned_thm_1 (e : IntW 8) :
  icmp IntPred.ugt (sext 32 e) (const? 32 17) ⊑ icmp IntPred.ugt e (const? 8 17) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_signed_to_small_signed_proof.gt_signed_to_small_signed_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (sext 32 e) (const? 32 17) ⊑ icmp IntPred.sgt e (const? 8 17) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_signed_to_small_negative_proof.gt_signed_to_small_negative_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (sext 32 e) (const? 32 (-17)) ⊑ icmp IntPred.sgt e (const? 8 (-17)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_unsigned_to_large_unsigned_proof.gt_unsigned_to_large_unsigned_thm_1 (e : IntW 8) :
  icmp IntPred.ugt (zext 32 e) (const? 32 1024) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_unsigned_to_large_signed_proof.gt_unsigned_to_large_signed_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (zext 32 e) (const? 32 1024) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_unsigned_to_large_negative_proof.gt_unsigned_to_large_negative_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (zext 32 e) (const? 32 (-1024)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_unsigned_to_small_unsigned_proof.gt_unsigned_to_small_unsigned_thm_1 (e : IntW 8) :
  icmp IntPred.ugt (zext 32 e) (const? 32 17) ⊑ icmp IntPred.ugt e (const? 8 17) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_unsigned_to_small_signed_proof.gt_unsigned_to_small_signed_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (zext 32 e) (const? 32 17) ⊑ icmp IntPred.ugt e (const? 8 17) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem gt_unsigned_to_small_negative_proof.gt_unsigned_to_small_negative_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (zext 32 e) (const? 32 (-17)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem different_size_zext_zext_ugt_proof.different_size_zext_zext_ugt_thm_1 (e : IntW 7) (e_1 : IntW 4) :
  icmp IntPred.ugt (zext 25 e) (zext 25 e_1) ⊑ icmp IntPred.ugt e (zext 7 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem different_size_zext_zext_ult_proof.different_size_zext_zext_ult_thm_1 (e : IntW 4) (e_1 : IntW 7) :
  icmp IntPred.ult (zext 25 e) (zext 25 e_1) ⊑ icmp IntPred.ugt e_1 (zext 7 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem different_size_zext_zext_eq_proof.different_size_zext_zext_eq_thm_1 (e : IntW 4) (e_1 : IntW 7) :
  icmp IntPred.eq (zext 25 e) (zext 25 e_1) ⊑ icmp IntPred.eq e_1 (zext 7 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem different_size_zext_zext_ne_commute_proof.different_size_zext_zext_ne_commute_thm_1 (e : IntW 7) (e_1 : IntW 4) :
  icmp IntPred.ne (zext 25 e) (zext 25 e_1) ⊑ icmp IntPred.ne e (zext 7 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem different_size_zext_zext_slt_proof.different_size_zext_zext_slt_thm_1 (e : IntW 7) (e_1 : IntW 4) :
  icmp IntPred.slt (zext 25 e) (zext 25 e_1) ⊑ icmp IntPred.ult e (zext 7 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem different_size_zext_zext_sgt_proof.different_size_zext_zext_sgt_thm_1 (e : IntW 7) (e_1 : IntW 4) :
  icmp IntPred.sgt (zext 25 e) (zext 25 e_1) ⊑ icmp IntPred.ugt e (zext 7 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem different_size_sext_sext_sgt_proof.different_size_sext_sext_sgt_thm_1 (e : IntW 7) (e_1 : IntW 4) :
  icmp IntPred.sgt (sext 25 e) (sext 25 e_1) ⊑ icmp IntPred.sgt e (sext 7 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem different_size_sext_sext_sle_proof.different_size_sext_sext_sle_thm_1 (e : IntW 7) (e_1 : IntW 4) :
  icmp IntPred.sle (sext 25 e) (sext 25 e_1) ⊑ icmp IntPred.sle e (sext 7 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem different_size_sext_sext_eq_proof.different_size_sext_sext_eq_thm_1 (e : IntW 7) (e_1 : IntW 4) :
  icmp IntPred.eq (sext 25 e) (sext 25 e_1) ⊑ icmp IntPred.eq e (sext 7 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem different_size_sext_sext_ule_proof.different_size_sext_sext_ule_thm_1 (e : IntW 7) (e_1 : IntW 4) :
  icmp IntPred.ule (sext 25 e) (sext 25 e_1) ⊑ icmp IntPred.ule e (sext 7 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
