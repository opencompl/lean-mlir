
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcanonicalizehshlhlshrhtohmasking_proof
theorem positive_samevar_proof.positive_samevar_thm_1 (e e_1 : IntW 32) :
  lshr (shl e e_1) e_1 ⊑ LLVM.and (lshr (const? 32 (-1)) e_1) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_sameconst_proof.positive_sameconst_thm_1 (e : IntW 32) :
  lshr (shl e (const? 32 5)) (const? 32 5) ⊑ LLVM.and e (const? 32 134217727) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerShl_proof.positive_biggerShl_thm_1 (e : IntW 32) :
  lshr (shl e (const? 32 10)) (const? 32 5) ⊑ LLVM.and (shl e (const? 32 5)) (const? 32 134217696) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerLshr_proof.positive_biggerLshr_thm_1 (e : IntW 32) :
  lshr (shl e (const? 32 5)) (const? 32 10) ⊑ LLVM.and (lshr e (const? 32 5)) (const? 32 4194303) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerLshr_lshrexact_proof.positive_biggerLshr_lshrexact_thm_1 (e : IntW 32) :
  lshr (shl e (const? 32 5)) (const? 32 10) { «exact» := true } ⊑
    LLVM.and (lshr e (const? 32 5) { «exact» := true }) (const? 32 4194303) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_samevar_shlnuw_proof.positive_samevar_shlnuw_thm_1 (e e_1 : IntW 32) :
  lshr (shl e e_1 { «nuw» := true }) e_1 ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_sameconst_shlnuw_proof.positive_sameconst_shlnuw_thm_1 (e : IntW 32) :
  lshr (shl e (const? 32 5) { «nuw» := true }) (const? 32 5) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerShl_shlnuw_proof.positive_biggerShl_shlnuw_thm_1 (e : IntW 32) :
  lshr (shl e (const? 32 10) { «nuw» := true }) (const? 32 5) ⊑
    shl e (const? 32 5) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerLshr_shlnuw_proof.positive_biggerLshr_shlnuw_thm_1 (e : IntW 32) :
  lshr (shl e (const? 32 5) { «nuw» := true }) (const? 32 10) ⊑ lshr e (const? 32 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerLshr_shlnuw_lshrexact_proof.positive_biggerLshr_shlnuw_lshrexact_thm_1 (e : IntW 32) :
  lshr (shl e (const? 32 5) { «nuw» := true }) (const? 32 10) { «exact» := true } ⊑
    lshr e (const? 32 5) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
