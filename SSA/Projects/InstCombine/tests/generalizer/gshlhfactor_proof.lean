
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshlhfactor_proof
theorem add_shl_same_amount_proof.add_shl_same_amount_thm_1 (e e_1 e_2 : IntW 6) :
  add (shl e e_2) (shl e_1 e_2) ⊑ shl (add e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_shl_same_amount_nuw_proof.add_shl_same_amount_nuw_thm_1 (e e_1 e_2 : IntW 64) :
  add (shl e e_2 { «nuw» := true }) (shl e_1 e_2 { «nuw» := true }) { «nuw» := true } ⊑
    shl (add e e_1 { «nuw» := true }) e_2 { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_shl_same_amount_partial_nsw1_proof.add_shl_same_amount_partial_nsw1_thm_1 (e e_1 e_2 : IntW 6) :
  add (shl e e_2 { «nsw» := true }) (shl e_1 e_2 { «nsw» := true }) ⊑ shl (add e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_shl_same_amount_partial_nsw2_proof.add_shl_same_amount_partial_nsw2_thm_1 (e e_1 e_2 : IntW 6) :
  add (shl e e_2) (shl e_1 e_2 { «nsw» := true }) { «nsw» := true } ⊑ shl (add e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_shl_same_amount_partial_nuw1_proof.add_shl_same_amount_partial_nuw1_thm_1 (e e_1 e_2 : IntW 6) :
  add (shl e e_2 { «nuw» := true }) (shl e_1 e_2 { «nuw» := true }) ⊑ shl (add e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_shl_same_amount_partial_nuw2_proof.add_shl_same_amount_partial_nuw2_thm_1 (e e_1 e_2 : IntW 6) :
  add (shl e e_2 { «nuw» := true }) (shl e_1 e_2) { «nuw» := true } ⊑ shl (add e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_shl_same_amount_proof.sub_shl_same_amount_thm_1 (e e_1 e_2 : IntW 6) :
  sub (shl e e_2) (shl e_1 e_2) ⊑ shl (sub e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_shl_same_amount_nuw_proof.sub_shl_same_amount_nuw_thm_1 (e e_1 e_2 : IntW 64) :
  sub (shl e e_2 { «nuw» := true }) (shl e_1 e_2 { «nuw» := true }) { «nuw» := true } ⊑
    shl (sub e e_1 { «nuw» := true }) e_2 { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_shl_same_amount_partial_nsw1_proof.sub_shl_same_amount_partial_nsw1_thm_1 (e e_1 e_2 : IntW 6) :
  sub (shl e e_2 { «nsw» := true }) (shl e_1 e_2 { «nsw» := true }) ⊑ shl (sub e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_shl_same_amount_partial_nsw2_proof.sub_shl_same_amount_partial_nsw2_thm_1 (e e_1 e_2 : IntW 6) :
  sub (shl e e_2) (shl e_1 e_2 { «nsw» := true }) { «nsw» := true } ⊑ shl (sub e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_shl_same_amount_partial_nuw1_proof.sub_shl_same_amount_partial_nuw1_thm_1 (e e_1 e_2 : IntW 6) :
  sub (shl e e_2 { «nuw» := true }) (shl e_1 e_2 { «nuw» := true }) ⊑ shl (sub e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_shl_same_amount_partial_nuw2_proof.sub_shl_same_amount_partial_nuw2_thm_1 (e e_1 e_2 : IntW 6) :
  sub (shl e e_2 { «nuw» := true }) (shl e_1 e_2) { «nuw» := true } ⊑ shl (sub e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_shl_same_amount_constants_proof.add_shl_same_amount_constants_thm_1 (e : IntW 8) :
  add (shl (const? 8 4) e) (shl (const? 8 3) e) ⊑ shl (const? 8 7) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
