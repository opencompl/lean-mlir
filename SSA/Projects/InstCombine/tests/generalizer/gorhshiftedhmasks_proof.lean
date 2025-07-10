
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gorhshiftedhmasks_proof
theorem or_and_shifts1_proof.or_and_shifts1_thm_1 (e : IntW 32) :
  LLVM.or (LLVM.and (shl e (const? 32 3)) (const? 32 15)) (LLVM.and (shl e (const? 32 5)) (const? 32 60)) ⊑
    LLVM.or (LLVM.and (shl e (const? 32 3)) (const? 32 8)) (LLVM.and (shl e (const? 32 5)) (const? 32 32))
      { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_shifts2_proof.or_and_shifts2_thm_1 (e : IntW 32) :
  LLVM.or (LLVM.and (shl e (const? 32 3)) (const? 32 896)) (LLVM.and (lshr e (const? 32 4)) (const? 32 7)) ⊑
    LLVM.or (LLVM.and (shl e (const? 32 3)) (const? 32 896)) (LLVM.and (lshr e (const? 32 4)) (const? 32 7))
      { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_and_shift_shift_and_proof.or_and_shift_shift_and_thm_1 (e : IntW 32) :
  LLVM.or (shl (LLVM.and e (const? 32 7)) (const? 32 3)) (LLVM.and (shl e (const? 32 2)) (const? 32 28)) ⊑
    LLVM.or (LLVM.and (shl e (const? 32 3)) (const? 32 56)) (LLVM.and (shl e (const? 32 2)) (const? 32 28)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem multiuse1_proof.multiuse1_thm_1 (e : IntW 32) :
  LLVM.or
      (LLVM.or (lshr (LLVM.and e (const? 32 2)) (const? 32 1) { «exact» := true })
        (lshr (LLVM.and e (const? 32 4)) (const? 32 1) { «exact» := true }))
      (LLVM.or (shl (LLVM.and e (const? 32 2)) (const? 32 6) { «nsw» := true, «nuw» := true })
        (shl (LLVM.and e (const? 32 4)) (const? 32 6) { «nsw» := true, «nuw» := true })) ⊑
    LLVM.or
      (LLVM.or (LLVM.and (lshr e (const? 32 1)) (const? 32 1)) (LLVM.and (lshr e (const? 32 1)) (const? 32 2))
        { «disjoint» := true })
      (LLVM.and (shl e (const? 32 6)) (const? 32 384)) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem multiuse2_proof.multiuse2_thm_1 (e : IntW 32) :
  LLVM.or
      (LLVM.or (shl (LLVM.and e (const? 32 96)) (const? 32 8) { «nsw» := true, «nuw» := true })
        (LLVM.or (shl (LLVM.and e (const? 32 6)) (const? 32 8) { «nsw» := true, «nuw» := true })
          (shl (LLVM.and e (const? 32 24)) (const? 32 8) { «nsw» := true, «nuw» := true })))
      (LLVM.or (shl (LLVM.and e (const? 32 6)) (const? 32 1) { «nsw» := true, «nuw» := true })
        (LLVM.or (shl (LLVM.and e (const? 32 96)) (const? 32 1) { «nsw» := true, «nuw» := true })
          (shl (LLVM.and e (const? 32 24)) (const? 32 1) { «nsw» := true, «nuw» := true }))) ⊑
    LLVM.or (LLVM.and (shl e (const? 32 8)) (const? 32 32256))
      (LLVM.or (LLVM.and (shl e (const? 32 1)) (const? 32 12))
        (LLVM.or (LLVM.and (shl e (const? 32 1)) (const? 32 192)) (LLVM.and (shl e (const? 32 1)) (const? 32 48))
          { «disjoint» := true })
        { «disjoint» := true })
      { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem multiuse3_proof.multiuse3_thm_1 (e : IntW 32) :
  LLVM.or
      (LLVM.or (lshr (LLVM.and e (const? 32 96)) (const? 32 1) { «exact» := true })
        (LLVM.and (lshr e (const? 32 1)) (const? 32 15)))
      (LLVM.or (shl (LLVM.and e (const? 32 96)) (const? 32 6) { «nsw» := true, «nuw» := true })
        (LLVM.and (shl e (const? 32 6)) (const? 32 1920))) ⊑
    LLVM.or
      (LLVM.or (LLVM.and (lshr e (const? 32 1)) (const? 32 48)) (LLVM.and (lshr e (const? 32 1)) (const? 32 15))
        { «disjoint» := true })
      (LLVM.and (shl e (const? 32 6)) (const? 32 8064)) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_mask_proof.shl_mask_thm_1 (e : IntW 32) :
  LLVM.or (LLVM.and e (const? 32 255)) (shl (LLVM.and e (const? 32 255)) (const? 32 8)) ⊑
    LLVM.or (LLVM.and e (const? 32 255))
      (shl (LLVM.and e (const? 32 255)) (const? 32 8) { «nsw» := true, «nuw» := true }) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_mask_wrong_shl_const_proof.shl_mask_wrong_shl_const_thm_1 (e : IntW 32) :
  LLVM.or (LLVM.and e (const? 32 255)) (shl (LLVM.and e (const? 32 255)) (const? 32 7)) ⊑
    LLVM.or (LLVM.and e (const? 32 255))
      (shl (LLVM.and e (const? 32 255)) (const? 32 7) { «nsw» := true, «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_mask_weird_type_proof.shl_mask_weird_type_thm_1 (e : IntW 37) :
  LLVM.or (LLVM.and e (const? 37 255)) (shl (LLVM.and e (const? 37 255)) (const? 37 8)) ⊑
    LLVM.or (LLVM.and e (const? 37 255))
      (shl (LLVM.and e (const? 37 255)) (const? 37 8) { «nsw» := true, «nuw» := true }) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_mul_mask_proof.shl_mul_mask_thm_1 (e : IntW 32) :
  LLVM.or (mul (LLVM.and e (const? 32 255)) (const? 32 65537)) (shl (LLVM.and e (const? 32 255)) (const? 32 8)) ⊑
    LLVM.or (mul (LLVM.and e (const? 32 255)) (const? 32 65537) { «nsw» := true, «nuw» := true })
      (shl (LLVM.and e (const? 32 255)) (const? 32 8) { «nsw» := true, «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_mul_mask_wrong_mul_const_proof.shl_mul_mask_wrong_mul_const_thm_1 (e : IntW 32) :
  LLVM.or (mul (LLVM.and e (const? 32 255)) (const? 32 65535)) (shl (LLVM.and e (const? 32 255)) (const? 32 8)) ⊑
    LLVM.or (mul (LLVM.and e (const? 32 255)) (const? 32 65535) { «nsw» := true, «nuw» := true })
      (shl (LLVM.and e (const? 32 255)) (const? 32 8) { «nsw» := true, «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
