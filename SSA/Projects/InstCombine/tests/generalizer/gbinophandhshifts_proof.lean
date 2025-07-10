
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gbinophandhshifts_proof
theorem shl_and_and_proof.shl_and_and_thm_1 (e e_1 : IntW 8) :
  LLVM.and (shl e (const? 8 4)) (LLVM.and (shl e_1 (const? 8 4)) (const? 8 88)) ⊑
    LLVM.and (shl (LLVM.and e_1 e) (const? 8 4)) (const? 8 80) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_and_and_fail_proof.shl_and_and_fail_thm_1 (e e_1 : IntW 8) :
  LLVM.and (shl e (const? 8 4)) (LLVM.and (shl e_1 (const? 8 5)) (const? 8 88)) ⊑
    LLVM.and (shl e (const? 8 4)) (LLVM.and (shl e_1 (const? 8 5)) (const? 8 64)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_add_add_proof.shl_add_add_thm_1 (e e_1 : IntW 8) :
  add (shl e (const? 8 2)) (add (shl e_1 (const? 8 2)) (const? 8 48)) ⊑
    add (shl (add e_1 e) (const? 8 2)) (const? 8 48) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_add_add_fail_proof.shl_add_add_fail_thm_1 (e e_1 : IntW 8) :
  add (lshr e (const? 8 2)) (add (lshr e_1 (const? 8 2)) (const? 8 48)) ⊑
    add (lshr e (const? 8 2)) (add (lshr e_1 (const? 8 2)) (const? 8 48) { «nsw» := true, «nuw» := true })
      { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_and_xor_proof.shl_and_xor_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (shl e_1 (const? 8 1)) (LLVM.and (shl e (const? 8 1)) (const? 8 20)) ⊑
    shl (LLVM.xor e_1 (LLVM.and e (const? 8 10))) (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_and_add_proof.shl_and_add_thm_1 (e e_1 : IntW 8) :
  add (shl e (const? 8 1)) (LLVM.and (shl e_1 (const? 8 1)) (const? 8 119)) ⊑
    shl (add e (LLVM.and e_1 (const? 8 59))) (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_or_and_proof.lshr_or_and_thm_1 (e e_1 : IntW 8) :
  LLVM.and (LLVM.or (lshr e (const? 8 5)) (const? 8 (-58))) (lshr e_1 (const? 8 5)) ⊑
    lshr (LLVM.and e_1 (LLVM.or e (const? 8 (-64)))) (const? 8 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_or_or_fail_proof.lshr_or_or_fail_thm_1 (e e_1 : IntW 8) :
  LLVM.or (lshr e (const? 8 5)) (LLVM.or (lshr e_1 (const? 8 5)) (const? 8 (-58))) ⊑
    LLVM.or (lshr (LLVM.or e_1 e) (const? 8 5)) (const? 8 (-58)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_or_or_no_const_proof.lshr_or_or_no_const_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.or (lshr e e_2) (LLVM.or (lshr e_1 e_2) e_3) ⊑ LLVM.or (lshr (LLVM.or e_1 e) e_2) e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_xor_xor_no_const_proof.shl_xor_xor_no_const_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  LLVM.xor (shl e e_2) (LLVM.xor (shl e_1 e_2) e_3) ⊑ LLVM.xor (shl (LLVM.xor e_1 e) e_2) e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_add_add_no_const_proof.shl_add_add_no_const_thm_1 (e e_1 e_2 e_3 : IntW 8) :
  add (shl e e_2) (add (shl e_1 e_2) e_3) ⊑ add (shl (add e_1 e) e_2) e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_xor_or_good_mask_proof.lshr_xor_or_good_mask_thm_1 (e e_1 : IntW 8) :
  LLVM.or (lshr e (const? 8 4)) (LLVM.xor (lshr e_1 (const? 8 4)) (const? 8 48)) ⊑
    LLVM.or (lshr (LLVM.or e_1 e) (const? 8 4)) (const? 8 48) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_xor_xor_good_mask_proof.shl_xor_xor_good_mask_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (shl e (const? 8 1)) (LLVM.xor (shl e_1 (const? 8 1)) (const? 8 88)) ⊑
    LLVM.xor (shl (LLVM.xor e_1 e) (const? 8 1)) (const? 8 88) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_xor_xor_bad_mask_distribute_proof.shl_xor_xor_bad_mask_distribute_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (shl e (const? 8 1)) (LLVM.xor (shl e_1 (const? 8 1)) (const? 8 (-68))) ⊑
    LLVM.xor (shl (LLVM.xor e_1 e) (const? 8 1)) (const? 8 (-68)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_add_and_proof.shl_add_and_thm_1 (e e_1 : IntW 8) :
  LLVM.and (shl e (const? 8 1)) (add (shl e_1 (const? 8 1)) (const? 8 123)) ⊑
    shl (LLVM.and e (add e_1 (const? 8 61))) (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_and_add_fail_proof.lshr_and_add_fail_thm_1 (e e_1 : IntW 8) :
  add (lshr e (const? 8 1)) (LLVM.and (lshr e_1 (const? 8 1)) (const? 8 123)) ⊑
    add (lshr e (const? 8 1)) (LLVM.and (lshr e_1 (const? 8 1)) (const? 8 123)) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_add_or_fail_proof.lshr_add_or_fail_thm_1 (e e_1 : IntW 8) :
  LLVM.or (lshr e (const? 8 1)) (add (lshr e_1 (const? 8 1)) (const? 8 123)) ⊑
    LLVM.or (lshr e (const? 8 1)) (add (lshr e_1 (const? 8 1)) (const? 8 123) { «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_add_xor_fail_proof.lshr_add_xor_fail_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (lshr e (const? 8 1)) (add (lshr e_1 (const? 8 1)) (const? 8 123)) ⊑
    LLVM.xor (lshr e (const? 8 1)) (add (lshr e_1 (const? 8 1)) (const? 8 123) { «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_add_and_fail_mismatch_shift_proof.shl_add_and_fail_mismatch_shift_thm_1 (e e_1 : IntW 8) :
  LLVM.and (shl e (const? 8 1)) (add (lshr e_1 (const? 8 1)) (const? 8 123)) ⊑
    LLVM.and (shl e (const? 8 1)) (add (lshr e_1 (const? 8 1)) (const? 8 123) { «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_ashr_not_proof.and_ashr_not_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.and (ashr e e_2) (LLVM.xor (ashr e_1 e_2) (const? 8 (-1))) ⊑
    ashr (LLVM.and e (LLVM.xor e_1 (const? 8 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_ashr_not_commuted_proof.and_ashr_not_commuted_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.and (LLVM.xor (ashr e_1 e_2) (const? 8 (-1))) (ashr e e_2) ⊑
    ashr (LLVM.and e (LLVM.xor e_1 (const? 8 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_ashr_not_proof.or_ashr_not_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (ashr e e_2) (LLVM.xor (ashr e_1 e_2) (const? 8 (-1))) ⊑
    ashr (LLVM.or e (LLVM.xor e_1 (const? 8 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_ashr_not_commuted_proof.or_ashr_not_commuted_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.xor (ashr e_1 e_2) (const? 8 (-1))) (ashr e e_2) ⊑
    ashr (LLVM.or e (LLVM.xor e_1 (const? 8 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_ashr_not_proof.xor_ashr_not_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.xor (ashr e e_2) (LLVM.xor (ashr e_1 e_2) (const? 8 (-1))) ⊑
    LLVM.xor (ashr (LLVM.xor e_1 e) e_2) (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_ashr_not_commuted_proof.xor_ashr_not_commuted_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.xor (LLVM.xor (ashr e_1 e_2) (const? 8 (-1))) (ashr e e_2) ⊑
    LLVM.xor (ashr (LLVM.xor e_1 e) e_2) (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_ashr_not_fail_lshr_ashr_proof.xor_ashr_not_fail_lshr_ashr_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.xor (lshr e e_2) (LLVM.xor (ashr e_1 e_2) (const? 8 (-1))) ⊑
    LLVM.xor (LLVM.xor (ashr e_1 e_2) (lshr e e_2)) (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_ashr_not_fail_ashr_lshr_proof.xor_ashr_not_fail_ashr_lshr_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.xor (ashr e e_2) (LLVM.xor (lshr e_1 e_2) (const? 8 (-1))) ⊑
    LLVM.xor (LLVM.xor (lshr e_1 e_2) (ashr e e_2)) (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_ashr_not_fail_invalid_xor_constant_proof.xor_ashr_not_fail_invalid_xor_constant_thm_1 (e e_1 e_2 : IntW 8) :
  LLVM.xor (ashr e e_2) (LLVM.xor (ashr e_1 e_2) (const? 8 (-2))) ⊑
    LLVM.xor (ashr (LLVM.xor e_1 e) e_2) (const? 8 (-2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
