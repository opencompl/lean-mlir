
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gtrunchbinophext_proof
theorem narrow_sext_and_proof.narrow_sext_and_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (LLVM.and (sext 32 e) e_1) ⊑ LLVM.and e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_zext_and_proof.narrow_zext_and_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (LLVM.and (zext 32 e) e_1) ⊑ LLVM.and e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_sext_or_proof.narrow_sext_or_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (LLVM.or (sext 32 e) e_1) ⊑ LLVM.or e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_zext_or_proof.narrow_zext_or_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (LLVM.or (zext 32 e) e_1) ⊑ LLVM.or e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_sext_xor_proof.narrow_sext_xor_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (LLVM.xor (sext 32 e) e_1) ⊑ LLVM.xor e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_zext_xor_proof.narrow_zext_xor_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (LLVM.xor (zext 32 e) e_1) ⊑ LLVM.xor e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_sext_add_proof.narrow_sext_add_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (add (sext 32 e) e_1) ⊑ add e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_zext_add_proof.narrow_zext_add_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (add (zext 32 e) e_1) ⊑ add e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_sext_sub_proof.narrow_sext_sub_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (sub (sext 32 e) e_1) ⊑ sub e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_zext_sub_proof.narrow_zext_sub_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (sub (zext 32 e) e_1) ⊑ sub e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_sext_mul_proof.narrow_sext_mul_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (mul (sext 32 e) e_1) ⊑ mul e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_zext_mul_proof.narrow_zext_mul_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  trunc 16 (mul (zext 32 e) e_1) ⊑ mul e (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_zext_ashr_keep_trunc_proof.narrow_zext_ashr_keep_trunc_thm_1 (e e_1 : IntW 8) :
  trunc 8 (ashr (add (sext 32 e) (sext 32 e_1) { «nsw» := true }) (const? 32 1)) ⊑
    trunc 8 (lshr (add (sext 16 e) (sext 16 e_1) { «nsw» := true }) (const? 16 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_zext_ashr_keep_trunc2_proof.narrow_zext_ashr_keep_trunc2_thm_1 (e e_1 : IntW 9) :
  trunc 8 (ashr (add (sext 64 e) (sext 64 e_1) { «nsw» := true }) (const? 64 1)) ⊑
    trunc 8 (lshr (add (zext 16 e) (zext 16 e_1) { «nsw» := true, «nuw» := true }) (const? 16 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem narrow_zext_ashr_keep_trunc3_proof.narrow_zext_ashr_keep_trunc3_thm_1 (e e_1 : IntW 8) :
  trunc 7 (ashr (add (sext 64 e) (sext 64 e_1) { «nsw» := true }) (const? 64 1)) ⊑
    trunc 7 (lshr (add (zext 14 e) (zext 14 e_1) { «nsw» := true, «nuw» := true }) (const? 14 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem dont_narrow_zext_ashr_keep_trunc_proof.dont_narrow_zext_ashr_keep_trunc_thm_1 (e e_1 : IntW 8) :
  trunc 8 (ashr (add (sext 16 e) (sext 16 e_1) { «nsw» := true }) (const? 16 1)) ⊑
    trunc 8 (lshr (add (sext 16 e) (sext 16 e_1) { «nsw» := true }) (const? 16 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
