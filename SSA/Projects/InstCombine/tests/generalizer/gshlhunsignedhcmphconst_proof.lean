
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshlhunsignedhcmphconst_proof
theorem scalar_i8_shl_ult_const_1_proof.scalar_i8_shl_ult_const_1_thm_1 (e : IntW 8) :
  icmp IntPred.ult (shl e (const? 8 5)) (const? 8 64) ⊑ icmp IntPred.eq (LLVM.and e (const? 8 6)) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i8_shl_ult_const_2_proof.scalar_i8_shl_ult_const_2_thm_1 (e : IntW 8) :
  icmp IntPred.ult (shl e (const? 8 6)) (const? 8 64) ⊑ icmp IntPred.eq (LLVM.and e (const? 8 3)) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i8_shl_ult_const_3_proof.scalar_i8_shl_ult_const_3_thm_1 (e : IntW 8) :
  icmp IntPred.ult (shl e (const? 8 7)) (const? 8 64) ⊑ icmp IntPred.eq (LLVM.and e (const? 8 1)) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i16_shl_ult_const_proof.scalar_i16_shl_ult_const_thm_1 (e : IntW 16) :
  icmp IntPred.ult (shl e (const? 16 8)) (const? 16 1024) ⊑
    icmp IntPred.eq (LLVM.and e (const? 16 252)) (const? 16 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i32_shl_ult_const_proof.scalar_i32_shl_ult_const_thm_1 (e : IntW 32) :
  icmp IntPred.ult (shl e (const? 32 11)) (const? 32 131072) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 2097088)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i64_shl_ult_const_proof.scalar_i64_shl_ult_const_thm_1 (e : IntW 64) :
  icmp IntPred.ult (shl e (const? 64 25)) (const? 64 8589934592) ⊑
    icmp IntPred.eq (LLVM.and e (const? 64 549755813632)) (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i8_shl_uge_const_proof.scalar_i8_shl_uge_const_thm_1 (e : IntW 8) :
  icmp IntPred.uge (shl e (const? 8 5)) (const? 8 64) ⊑ icmp IntPred.ne (LLVM.and e (const? 8 6)) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i8_shl_ule_const_proof.scalar_i8_shl_ule_const_thm_1 (e : IntW 8) :
  icmp IntPred.ule (shl e (const? 8 5)) (const? 8 63) ⊑ icmp IntPred.eq (LLVM.and e (const? 8 6)) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i8_shl_ugt_const_proof.scalar_i8_shl_ugt_const_thm_1 (e : IntW 8) :
  icmp IntPred.ugt (shl e (const? 8 5)) (const? 8 63) ⊑ icmp IntPred.ne (LLVM.and e (const? 8 6)) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
