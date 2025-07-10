
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcanonicalizehlshrhshlhtohmasking_proof
theorem positive_samevar_proof.positive_samevar_thm_1 (e e_1 : IntW 8) :
  shl (lshr e e_1) e_1 ⊑ LLVM.and (shl (const? 8 (-1)) e_1 { «nsw» := true }) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_sameconst_proof.positive_sameconst_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3)) (const? 8 3) ⊑ LLVM.and e (const? 8 (-8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerlshr_proof.positive_biggerlshr_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 6)) (const? 8 3) ⊑ LLVM.and (lshr e (const? 8 3)) (const? 8 24) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggershl_proof.positive_biggershl_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3)) (const? 8 6) ⊑ LLVM.and (shl e (const? 8 3)) (const? 8 (-64)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_samevar_shlnuw_proof.positive_samevar_shlnuw_thm_1 (e e_1 : IntW 8) :
  shl (lshr e e_1) e_1 { «nuw» := true } ⊑ LLVM.and (shl (const? 8 (-1)) e_1 { «nsw» := true }) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_sameconst_shlnuw_proof.positive_sameconst_shlnuw_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3)) (const? 8 3) { «nuw» := true } ⊑ LLVM.and e (const? 8 (-8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerlshr_shlnuw_proof.positive_biggerlshr_shlnuw_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 6)) (const? 8 3) { «nuw» := true } ⊑ LLVM.and (lshr e (const? 8 3)) (const? 8 24) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggershl_shlnuw_proof.positive_biggershl_shlnuw_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3)) (const? 8 6) { «nuw» := true } ⊑
    LLVM.and (shl e (const? 8 3) { «nuw» := true }) (const? 8 (-64)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_samevar_shlnsw_proof.positive_samevar_shlnsw_thm_1 (e e_1 : IntW 8) :
  shl (lshr e e_1) e_1 { «nsw» := true } ⊑ LLVM.and (shl (const? 8 (-1)) e_1 { «nsw» := true }) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_sameconst_shlnsw_proof.positive_sameconst_shlnsw_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3)) (const? 8 3) { «nsw» := true } ⊑ LLVM.and e (const? 8 (-8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerlshr_shlnsw_proof.positive_biggerlshr_shlnsw_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 6)) (const? 8 3) { «nsw» := true } ⊑ LLVM.and (lshr e (const? 8 3)) (const? 8 24) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggershl_shlnsw_proof.positive_biggershl_shlnsw_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3)) (const? 8 6) { «nsw» := true } ⊑
    LLVM.and (shl e (const? 8 3) { «nsw» := true, «nuw» := true }) (const? 8 64) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_samevar_shlnuwnsw_proof.positive_samevar_shlnuwnsw_thm_1 (e e_1 : IntW 8) :
  shl (lshr e e_1) e_1 { «nsw» := true, «nuw» := true } ⊑
    LLVM.and (shl (const? 8 (-1)) e_1 { «nsw» := true }) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_sameconst_shlnuwnsw_proof.positive_sameconst_shlnuwnsw_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3)) (const? 8 3) { «nsw» := true, «nuw» := true } ⊑ LLVM.and e (const? 8 (-8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerlshr_shlnuwnsw_proof.positive_biggerlshr_shlnuwnsw_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 6)) (const? 8 3) { «nsw» := true, «nuw» := true } ⊑
    LLVM.and (lshr e (const? 8 3)) (const? 8 24) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggershl_shlnuwnsw_proof.positive_biggershl_shlnuwnsw_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3)) (const? 8 6) { «nsw» := true, «nuw» := true } ⊑
    LLVM.and (shl e (const? 8 3) { «nsw» := true, «nuw» := true }) (const? 8 64) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_samevar_lshrexact_proof.positive_samevar_lshrexact_thm_1 (e e_1 : IntW 8) :
  shl (lshr e e_1 { «exact» := true }) e_1 ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_sameconst_lshrexact_proof.positive_sameconst_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3) { «exact» := true }) (const? 8 3) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerlshr_lshrexact_proof.positive_biggerlshr_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 6) { «exact» := true }) (const? 8 3) ⊑ lshr e (const? 8 3) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggershl_lshrexact_proof.positive_biggershl_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3) { «exact» := true }) (const? 8 6) ⊑ shl e (const? 8 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_samevar_shlnsw_lshrexact_proof.positive_samevar_shlnsw_lshrexact_thm_1 (e e_1 : IntW 8) :
  shl (lshr e e_1 { «exact» := true }) e_1 { «nsw» := true } ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_sameconst_shlnsw_lshrexact_proof.positive_sameconst_shlnsw_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3) { «exact» := true }) (const? 8 3) { «nsw» := true } ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerlshr_shlnsw_lshrexact_proof.positive_biggerlshr_shlnsw_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 6) { «exact» := true }) (const? 8 3) { «nsw» := true } ⊑
    lshr e (const? 8 3) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggershl_shlnsw_lshrexact_proof.positive_biggershl_shlnsw_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3) { «exact» := true }) (const? 8 6) { «nsw» := true } ⊑
    shl e (const? 8 3) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_samevar_shlnuw_lshrexact_proof.positive_samevar_shlnuw_lshrexact_thm_1 (e e_1 : IntW 8) :
  shl (lshr e e_1 { «exact» := true }) e_1 { «nuw» := true } ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_sameconst_shlnuw_lshrexact_proof.positive_sameconst_shlnuw_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3) { «exact» := true }) (const? 8 3) { «nuw» := true } ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerlshr_shlnuw_lshrexact_proof.positive_biggerlshr_shlnuw_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 6) { «exact» := true }) (const? 8 3) { «nuw» := true } ⊑
    lshr e (const? 8 3) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggershl_shlnuw_lshrexact_proof.positive_biggershl_shlnuw_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3) { «exact» := true }) (const? 8 6) { «nuw» := true } ⊑
    shl e (const? 8 3) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_samevar_shlnuwnsw_lshrexact_proof.positive_samevar_shlnuwnsw_lshrexact_thm_1 (e e_1 : IntW 8) :
  shl (lshr e e_1 { «exact» := true }) e_1 { «nsw» := true, «nuw» := true } ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_sameconst_shlnuwnsw_lshrexact_proof.positive_sameconst_shlnuwnsw_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3) { «exact» := true }) (const? 8 3) { «nsw» := true, «nuw» := true } ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggerlshr_shlnuwnsw_lshrexact_proof.positive_biggerlshr_shlnuwnsw_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 6) { «exact» := true }) (const? 8 3) { «nsw» := true, «nuw» := true } ⊑
    lshr e (const? 8 3) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem positive_biggershl_shlnuwnsw_lshrexact_proof.positive_biggershl_shlnuwnsw_lshrexact_thm_1 (e : IntW 8) :
  shl (lshr e (const? 8 3) { «exact» := true }) (const? 8 6) { «nsw» := true, «nuw» := true } ⊑
    shl e (const? 8 3) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
