
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gbswap_proof
theorem test1_trunc_proof.test1_trunc_thm_1 (e : IntW 32) :
  trunc 16 (LLVM.or (lshr e (const? 32 24)) (LLVM.and (lshr e (const? 32 8)) (const? 32 65280))) ⊑
    trunc 16
      (LLVM.or (lshr e (const? 32 24)) (LLVM.and (lshr e (const? 32 8)) (const? 32 65280)) { «disjoint» := true })
      { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR39793_bswap_u64_as_u16_trunc_proof.PR39793_bswap_u64_as_u16_trunc_thm_1 (e : IntW 64) :
  trunc 8
      (LLVM.or (LLVM.and (lshr e (const? 64 8)) (const? 64 255)) (LLVM.and (shl e (const? 64 8)) (const? 64 65280))) ⊑
    trunc 8 (lshr e (const? 64 8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR39793_bswap_u32_as_u16_trunc_proof.PR39793_bswap_u32_as_u16_trunc_thm_1 (e : IntW 32) :
  trunc 8
      (LLVM.or (LLVM.and (lshr e (const? 32 8)) (const? 32 255)) (LLVM.and (shl e (const? 32 8)) (const? 32 65280))) ⊑
    trunc 8 (lshr e (const? 32 8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bswap_and_mask_1_proof.bswap_and_mask_1_thm_1 (e : IntW 64) :
  LLVM.or (LLVM.and (lshr e (const? 64 40)) (const? 64 65280)) (lshr e (const? 64 56)) ⊑
    LLVM.or (LLVM.and (lshr e (const? 64 40)) (const? 64 65280)) (lshr e (const? 64 56)) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
