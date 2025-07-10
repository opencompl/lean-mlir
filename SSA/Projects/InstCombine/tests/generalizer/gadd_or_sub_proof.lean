
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gadd_or_sub_proof
theorem add_or_sub_comb_i32_commuted1_nuw_proof.add_or_sub_comb_i32_commuted1_nuw_thm_1 (e : IntW 32) :
  add (LLVM.or (sub (const? 32 0) e) e) e { «nuw» := true } ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_or_sub_comb_i8_commuted2_nsw_proof.add_or_sub_comb_i8_commuted2_nsw_thm_1 (e : IntW 8) :
  add (mul e e) (LLVM.or (sub (const? 8 0) (mul e e)) (mul e e)) { «nsw» := true } ⊑
    LLVM.and (add (mul e e) (const? 8 (-1)) { «nsw» := true }) (mul e e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_or_sub_comb_i128_commuted3_nuw_nsw_proof.add_or_sub_comb_i128_commuted3_nuw_nsw_thm_1 (e : IntW 128) :
  add (LLVM.or (mul e e) (sub (const? 128 0) (mul e e))) (mul e e) { «nsw» := true, «nuw» := true } ⊑ mul e e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_or_sub_comb_i64_commuted4_proof.add_or_sub_comb_i64_commuted4_thm_1 (e : IntW 64) :
  add (mul e e) (LLVM.or (mul e e) (sub (const? 64 0) (mul e e))) ⊑
    LLVM.and (add (mul e e) (const? 64 (-1))) (mul e e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_or_sub_comb_i8_negative_y_sub_proof.add_or_sub_comb_i8_negative_y_sub_thm_1 (e e_1 : IntW 8) :
  add (LLVM.or (sub (const? 8 0) e_1) e) e ⊑ add (LLVM.or e (sub (const? 8 0) e_1)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_or_sub_comb_i8_negative_y_or_proof.add_or_sub_comb_i8_negative_y_or_thm_1 (e e_1 : IntW 8) :
  add (LLVM.or (sub (const? 8 0) e) e_1) e ⊑ add (LLVM.or e_1 (sub (const? 8 0) e)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_or_sub_comb_i8_negative_y_add_proof.add_or_sub_comb_i8_negative_y_add_thm_1 (e e_1 : IntW 8) :
  add (LLVM.or (sub (const? 8 0) e) e) e_1 ⊑ add (LLVM.or e (sub (const? 8 0) e)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_or_sub_comb_i8_negative_xor_instead_or_proof.add_or_sub_comb_i8_negative_xor_instead_or_thm_1 (e : IntW 8) :
  add (LLVM.xor (sub (const? 8 0) e) e) e ⊑ add (LLVM.xor e (sub (const? 8 0) e)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
