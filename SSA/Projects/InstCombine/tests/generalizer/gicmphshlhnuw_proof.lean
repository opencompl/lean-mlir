
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphshlhnuw_proof
theorem icmp_ugt_32_proof.icmp_ugt_32_thm_1 (e : IntW 64) :
  icmp IntPred.ugt (shl e (const? 64 32) { «nuw» := true }) (const? 64 4294967295) ⊑
    icmp IntPred.ne e (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_ule_64_proof.icmp_ule_64_thm_1 (e : IntW 128) :
  icmp IntPred.ule (shl e (const? 128 64) { «nuw» := true }) (const? 128 18446744073709551615) ⊑
    icmp IntPred.eq e (const? 128 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_ugt_16_proof.icmp_ugt_16_thm_1 (e : IntW 64) :
  icmp IntPred.ugt (shl e (const? 64 16) { «nuw» := true }) (const? 64 1048575) ⊑
    icmp IntPred.ugt e (const? 64 15) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_ult_8_proof.icmp_ult_8_thm_1 (e : IntW 64) :
  icmp IntPred.ult (shl e (const? 64 8) { «nuw» := true }) (const? 64 4095) ⊑ icmp IntPred.ult e (const? 64 16) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_icmp_shl_nuw_c1_proof.fold_icmp_shl_nuw_c1_thm_1 (e : IntW 32) :
  icmp IntPred.ult (shl (const? 32 2) (LLVM.and (lshr e (const? 32 12)) (const? 32 15)) { «nuw» := true })
      (const? 32 4) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 61440)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_icmp_shl_nuw_c2_proof.fold_icmp_shl_nuw_c2_thm_1 (e : IntW 32) :
  icmp IntPred.ult (shl (const? 32 16) e { «nuw» := true }) (const? 32 64) ⊑ icmp IntPred.ult e (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_icmp_shl_nuw_c2_non_pow2_proof.fold_icmp_shl_nuw_c2_non_pow2_thm_1 (e : IntW 32) :
  icmp IntPred.ult (shl (const? 32 48) e { «nuw» := true }) (const? 32 192) ⊑ icmp IntPred.ult e (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_icmp_shl_nuw_c2_div_non_pow2_proof.fold_icmp_shl_nuw_c2_div_non_pow2_thm_1 (e : IntW 32) :
  icmp IntPred.ult (shl (const? 32 2) e { «nuw» := true }) (const? 32 60) ⊑ icmp IntPred.ult e (const? 32 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_icmp_shl_nuw_c3_proof.fold_icmp_shl_nuw_c3_thm_1 (e : IntW 32) :
  icmp IntPred.uge (shl (const? 32 48) e { «nuw» := true }) (const? 32 144) ⊑ icmp IntPred.ugt e (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_icmp_shl_nuw_c2_indivisible_proof.fold_icmp_shl_nuw_c2_indivisible_thm_1 (e : IntW 32) :
  icmp IntPred.ult (shl (const? 32 16) e { «nuw» := true }) (const? 32 63) ⊑ icmp IntPred.ult e (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_icmp_shl_nuw_c2_precondition1_proof.fold_icmp_shl_nuw_c2_precondition1_thm_1 (e : IntW 32) :
  icmp IntPred.ult (shl (const? 32 0) e { «nuw» := true }) (const? 32 63) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_icmp_shl_nuw_c2_precondition2_proof.fold_icmp_shl_nuw_c2_precondition2_thm_1 (e : IntW 32) :
  icmp IntPred.ult (shl (const? 32 127) e { «nuw» := true }) (const? 32 63) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_icmp_shl_nuw_c2_precondition3_proof.fold_icmp_shl_nuw_c2_precondition3_thm_1 (e : IntW 32) :
  icmp IntPred.ult (shl (const? 32 1) e { «nuw» := true }) (const? 32 1) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
