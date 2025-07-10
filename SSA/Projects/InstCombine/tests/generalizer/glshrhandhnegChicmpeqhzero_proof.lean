
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section glshrhandhnegChicmpeqhzero_proof
theorem scalar_i8_lshr_and_negC_eq_proof.scalar_i8_lshr_and_negC_eq_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.and (lshr e e_1) (const? 8 (-4))) (const? 8 0) ⊑
    icmp IntPred.ult (lshr e e_1) (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i16_lshr_and_negC_eq_proof.scalar_i16_lshr_and_negC_eq_thm_1 (e e_1 : IntW 16) :
  icmp IntPred.eq (LLVM.and (lshr e e_1) (const? 16 (-128))) (const? 16 0) ⊑
    icmp IntPred.ult (lshr e e_1) (const? 16 128) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i32_lshr_and_negC_eq_proof.scalar_i32_lshr_and_negC_eq_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and (lshr e e_1) (const? 32 (-262144))) (const? 32 0) ⊑
    icmp IntPred.ult (lshr e e_1) (const? 32 262144) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i64_lshr_and_negC_eq_proof.scalar_i64_lshr_and_negC_eq_thm_1 (e e_1 : IntW 64) :
  icmp IntPred.eq (LLVM.and (lshr e e_1) (const? 64 (-8589934592))) (const? 64 0) ⊑
    icmp IntPred.ult (lshr e e_1) (const? 64 8589934592) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i32_lshr_and_negC_ne_proof.scalar_i32_lshr_and_negC_ne_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.and (lshr e e_1) (const? 32 (-262144))) (const? 32 0) ⊑
    icmp IntPred.ugt (lshr e e_1) (const? 32 262143) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i32_lshr_and_negC_eq_X_is_constant1_proof.scalar_i32_lshr_and_negC_eq_X_is_constant1_thm_1 (e : IntW 32) :
  icmp IntPred.eq (LLVM.and (lshr (const? 32 12345) e) (const? 32 (-8))) (const? 32 0) ⊑
    icmp IntPred.ult (lshr (const? 32 12345) e) (const? 32 8) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i32_lshr_and_negC_eq_X_is_constant2_proof.scalar_i32_lshr_and_negC_eq_X_is_constant2_thm_1 (e : IntW 32) :
  icmp IntPred.eq (LLVM.and (lshr (const? 32 268435456) e) (const? 32 (-8))) (const? 32 0) ⊑
    icmp IntPred.ugt e (const? 32 25) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i32_udiv_and_negC_eq_X_is_constant3_proof.scalar_i32_udiv_and_negC_eq_X_is_constant3_thm_1 (e : IntW 32) :
  icmp IntPred.ne (LLVM.and (LLVM.udiv (const? 32 12345) e) (const? 32 16376)) (const? 32 0) ⊑
    icmp IntPred.ult e (const? 32 1544) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i32_lshr_and_negC_slt_proof.scalar_i32_lshr_and_negC_slt_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.slt (LLVM.and (lshr e e_1) (const? 32 (-8))) (const? 32 0) ⊑
    icmp IntPred.slt (lshr e e_1) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i32_lshr_and_negC_eq_nonzero_proof.scalar_i32_lshr_and_negC_eq_nonzero_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and (lshr e e_1) (const? 32 (-8))) (const? 32 1) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2_proof.scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.and (lshr e e_1) (const? 8 (-3))) (const? 8 0) ⊑
    icmp IntPred.eq (LLVM.and e (shl (const? 8 (-3)) e_1)) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
