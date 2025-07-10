
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthamounthreassociation_proof
theorem t0_proof.t0_thm_1 (e e_1 : IntW 32) :
  lshr (lshr e (sub (const? 32 32) e_1)) (add e_1 (const? 32 (-2))) { «exact» := true } ⊑ lshr e (const? 32 30) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t6_shl_proof.t6_shl_thm_1 (e e_1 : IntW 32) :
  shl (shl e (sub (const? 32 32) e_1) { «nuw» := true }) (add e_1 (const? 32 (-2))) { «nsw» := true } ⊑
    shl e (const? 32 30) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t7_ashr_proof.t7_ashr_thm_1 (e e_1 : IntW 32) :
  ashr (ashr e (sub (const? 32 32) e_1) { «exact» := true }) (add e_1 (const? 32 (-2))) ⊑ ashr e (const? 32 30) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t8_lshr_exact_flag_preservation_proof.t8_lshr_exact_flag_preservation_thm_1 (e e_1 : IntW 32) :
  lshr (lshr e (sub (const? 32 32) e_1) { «exact» := true }) (add e_1 (const? 32 (-2))) { «exact» := true } ⊑
    lshr e (const? 32 30) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t9_ashr_exact_flag_preservation_proof.t9_ashr_exact_flag_preservation_thm_1 (e e_1 : IntW 32) :
  ashr (ashr e (sub (const? 32 32) e_1) { «exact» := true }) (add e_1 (const? 32 (-2))) { «exact» := true } ⊑
    ashr e (const? 32 30) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t10_shl_nuw_flag_preservation_proof.t10_shl_nuw_flag_preservation_thm_1 (e e_1 : IntW 32) :
  shl (shl e (sub (const? 32 32) e_1) { «nuw» := true }) (add e_1 (const? 32 (-2))) { «nsw» := true, «nuw» := true } ⊑
    shl e (const? 32 30) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t11_shl_nsw_flag_preservation_proof.t11_shl_nsw_flag_preservation_thm_1 (e e_1 : IntW 32) :
  shl (shl e (sub (const? 32 32) e_1) { «nsw» := true }) (add e_1 (const? 32 (-2))) { «nsw» := true, «nuw» := true } ⊑
    shl e (const? 32 30) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
