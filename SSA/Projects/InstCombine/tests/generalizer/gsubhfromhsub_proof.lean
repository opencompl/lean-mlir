
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsubhfromhsub_proof
theorem t0_proof.t0_thm_1 (e e_1 e_2 : IntW 8) : sub (sub e e_1) e_2 ⊑ sub e (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_flags_proof.t1_flags_thm_1 (e e_1 e_2 : IntW 8) :
  sub (sub e e_1 { «nsw» := true, «nuw» := true }) e_2 { «nsw» := true, «nuw» := true } ⊑
    sub e (add e_1 e_2 { «nsw» := true, «nuw» := true }) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_flags_nuw_only_proof.t1_flags_nuw_only_thm_1 (e e_1 e_2 : IntW 8) :
  sub (sub e e_1 { «nuw» := true }) e_2 { «nuw» := true } ⊑
    sub e (add e_1 e_2 { «nuw» := true }) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_flags_sub_nsw_sub_proof.t1_flags_sub_nsw_sub_thm_1 (e e_1 e_2 : IntW 8) :
  sub (sub e e_1 { «nsw» := true }) e_2 ⊑ sub e (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_flags_nuw_first_proof.t1_flags_nuw_first_thm_1 (e e_1 e_2 : IntW 8) :
  sub (sub e e_1 { «nuw» := true }) e_2 ⊑ sub e (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_flags_nuw_second_proof.t1_flags_nuw_second_thm_1 (e e_1 e_2 : IntW 8) :
  sub (sub e e_1) e_2 { «nuw» := true } ⊑ sub e (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_flags_nuw_nsw_first_proof.t1_flags_nuw_nsw_first_thm_1 (e e_1 e_2 : IntW 8) :
  sub (sub e e_1 { «nsw» := true, «nuw» := true }) e_2 ⊑ sub e (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_flags_nuw_nsw_second_proof.t1_flags_nuw_nsw_second_thm_1 (e e_1 e_2 : IntW 8) :
  sub (sub e e_1) e_2 { «nsw» := true, «nuw» := true } ⊑ sub e (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t3_c0_proof.t3_c0_thm_1 (e e_1 : IntW 8) :
  sub (sub (const? 8 42) e) e_1 ⊑ sub (const? 8 42) (add e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t4_c1_proof.t4_c1_thm_1 (e e_1 : IntW 8) :
  sub (sub e (const? 8 42)) e_1 ⊑ sub (add e (const? 8 (-42))) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t5_c2_proof.t5_c2_thm_1 (e e_1 : IntW 8) :
  sub (sub e e_1) (const? 8 42) ⊑ add (sub e e_1) (const? 8 (-42)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t9_c0_c2_proof.t9_c0_c2_thm_1 (e : IntW 8) :
  sub (sub (const? 8 42) e) (const? 8 24) ⊑ sub (const? 8 18) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t10_c1_c2_proof.t10_c1_c2_thm_1 (e : IntW 8) :
  sub (sub e (const? 8 42)) (const? 8 24) ⊑ add e (const? 8 (-66)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
