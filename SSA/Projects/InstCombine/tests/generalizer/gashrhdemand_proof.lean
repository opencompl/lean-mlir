
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gashrhdemand_proof
theorem srem2_ashr_mask_proof.srem2_ashr_mask_thm_1 (e : IntW 32) :
  LLVM.and (ashr (LLVM.srem e (const? 32 2)) (const? 32 31)) (const? 32 2) ⊑
    LLVM.and (LLVM.srem e (const? 32 2)) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem srem8_ashr_mask_proof.srem8_ashr_mask_thm_1 (e : IntW 32) :
  LLVM.and (ashr (LLVM.srem e (const? 32 8)) (const? 32 31)) (const? 32 2) ⊑
    select (icmp IntPred.ugt (LLVM.and e (const? 32 (-2147483641))) (const? 32 (-2147483648))) (const? 32 2)
      (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_can_be_lshr_proof.ashr_can_be_lshr_thm_1 (e : IntW 32) :
  trunc 16 (ashr e (const? 32 16) { «exact» := true }) { «nsw» := true } ⊑
    trunc 16 (lshr e (const? 32 16) { «exact» := true }) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_can_be_lshr_2_proof.ashr_can_be_lshr_2_thm_1 (e : IntW 32) :
  trunc 32 (ashr (shl (LLVM.or (zext 64 e) (const? 64 4278190080)) (const? 64 34)) (const? 64 32) { «exact» := true })
      { «nsw» := true } ⊑
    LLVM.or (shl e (const? 32 2)) (const? 32 (-67108864)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
