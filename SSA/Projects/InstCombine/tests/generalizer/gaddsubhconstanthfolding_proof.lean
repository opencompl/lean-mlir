
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gaddsubhconstanthfolding_proof
theorem add_const_add_const_proof.add_const_add_const_thm_1 (e : IntW 32) :
  add (add e (const? 32 8)) (const? 32 2) ⊑ add e (const? 32 10) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_const_sub_const_proof.add_const_sub_const_thm_1 (e : IntW 32) :
  sub (add e (const? 32 8)) (const? 32 2) ⊑ add e (const? 32 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_const_const_sub_proof.add_const_const_sub_thm_1 (e : IntW 32) :
  sub (const? 32 2) (add e (const? 32 8)) ⊑ sub (const? 32 (-6)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nsw_const_const_sub_nsw_proof.add_nsw_const_const_sub_nsw_thm_1 (e : IntW 8) :
  sub (const? 8 (-127)) (add e (const? 8 1) { «nsw» := true }) { «nsw» := true } ⊑
    sub (const? 8 (-128)) e { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nsw_const_const_sub_proof.add_nsw_const_const_sub_thm_1 (e : IntW 8) :
  sub (const? 8 (-127)) (add e (const? 8 1) { «nsw» := true }) ⊑ sub (const? 8 (-128)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_const_const_sub_nsw_proof.add_const_const_sub_nsw_thm_1 (e : IntW 8) :
  sub (const? 8 (-127)) (add e (const? 8 1)) { «nsw» := true } ⊑ sub (const? 8 (-128)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nsw_const_const_sub_nsw_ov_proof.add_nsw_const_const_sub_nsw_ov_thm_1 (e : IntW 8) :
  sub (const? 8 (-127)) (add e (const? 8 2) { «nsw» := true }) { «nsw» := true } ⊑ sub (const? 8 127) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nuw_const_const_sub_nuw_proof.add_nuw_const_const_sub_nuw_thm_1 (e : IntW 8) :
  sub (const? 8 (-127)) (add e (const? 8 1) { «nuw» := true }) { «nuw» := true } ⊑
    sub (const? 8 (-128)) e { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nuw_const_const_sub_proof.add_nuw_const_const_sub_thm_1 (e : IntW 8) :
  sub (const? 8 (-127)) (add e (const? 8 1) { «nuw» := true }) ⊑ sub (const? 8 (-128)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_const_const_sub_nuw_proof.add_const_const_sub_nuw_thm_1 (e : IntW 8) :
  sub (const? 8 (-127)) (add e (const? 8 1)) { «nuw» := true } ⊑ sub (const? 8 (-128)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_const_add_const_proof.sub_const_add_const_thm_1 (e : IntW 32) :
  add (sub e (const? 32 8)) (const? 32 2) ⊑ add e (const? 32 (-6)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_const_sub_const_proof.sub_const_sub_const_thm_1 (e : IntW 32) :
  sub (sub e (const? 32 8)) (const? 32 2) ⊑ add e (const? 32 (-10)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_const_const_sub_proof.sub_const_const_sub_thm_1 (e : IntW 32) :
  sub (const? 32 2) (sub e (const? 32 8)) ⊑ sub (const? 32 10) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem const_sub_add_const_proof.const_sub_add_const_thm_1 (e : IntW 32) :
  add (sub (const? 32 8) e) (const? 32 2) ⊑ sub (const? 32 10) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem const_sub_sub_const_proof.const_sub_sub_const_thm_1 (e : IntW 32) :
  sub (sub (const? 32 8) e) (const? 32 2) ⊑ sub (const? 32 6) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem const_sub_const_sub_proof.const_sub_const_sub_thm_1 (e : IntW 32) :
  sub (const? 32 2) (sub (const? 32 8) e) ⊑ add e (const? 32 (-6)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem addsub_combine_constants_proof.addsub_combine_constants_thm_1 (e e_1 : IntW 7) :
  add (add e (const? 7 42)) (sub (const? 7 10) e_1) { «nsw» := true } ⊑ add (sub e e_1) (const? 7 52) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_from_constant_proof.sub_from_constant_thm_1 (e e_1 : IntW 5) :
  add (sub (const? 5 10) e) e_1 ⊑ add (sub e_1 e) (const? 5 10) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_from_constant_commute_proof.sub_from_constant_commute_thm_1 (e e_1 : IntW 5) :
  add (mul e_1 e_1) (sub (const? 5 10) e { «nsw» := true }) { «nsw» := true } ⊑
    add (sub (mul e_1 e_1) e) (const? 5 10) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
