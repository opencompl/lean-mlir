
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthbinophcmp_proof
theorem select_xor_icmp_proof.select_xor_icmp_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (LLVM.xor e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 0)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_xor_icmp2_proof.select_xor_icmp2_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ne e (const? 32 0)) e_1 (LLVM.xor e e_2) ⊑
    select (icmp IntPred.eq e (const? 32 0)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_xor_icmp_meta_proof.select_xor_icmp_meta_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (LLVM.xor e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 0)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_mul_icmp_proof.select_mul_icmp_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 1)) (mul e e_2) e_1 ⊑ select (icmp IntPred.eq e (const? 32 1)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_add_icmp_proof.select_add_icmp_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (add e e_2) e_1 ⊑ select (icmp IntPred.eq e (const? 32 0)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_or_icmp_proof.select_or_icmp_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (LLVM.or e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 0)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_and_icmp_proof.select_and_icmp_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 (-1))) (LLVM.and e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 (-1))) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_xor_inv_icmp_proof.select_xor_inv_icmp_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (LLVM.xor e_2 e) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 0)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_sub_icmp_proof.select_sub_icmp_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (sub e_2 e) e_1 ⊑ select (icmp IntPred.eq e (const? 32 0)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_lshr_icmp_proof.select_lshr_icmp_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (lshr e_2 e) e_1 ⊑ select (icmp IntPred.eq e (const? 32 0)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_udiv_icmp_proof.select_udiv_icmp_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 1)) (LLVM.udiv e_2 e) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 1)) e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_xor_icmp_bad_3_proof.select_xor_icmp_bad_3_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 3)) (LLVM.xor e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 3)) (LLVM.xor e_2 (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_xor_icmp_bad_5_proof.select_xor_icmp_bad_5_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ne e (const? 32 0)) (LLVM.xor e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 0)) e_1 (LLVM.xor e e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_xor_icmp_bad_6_proof.select_xor_icmp_bad_6_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ne e (const? 32 1)) e_1 (LLVM.xor e e_2) ⊑
    select (icmp IntPred.eq e (const? 32 1)) (LLVM.xor e_2 (const? 32 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_mul_icmp_bad_proof.select_mul_icmp_bad_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 3)) (mul e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 3)) (mul e_2 (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_add_icmp_bad_proof.select_add_icmp_bad_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 1)) (add e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 1)) (add e_2 (const? 32 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_and_icmp_zero_proof.select_and_icmp_zero_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (LLVM.and e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 0)) (const? 32 0) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_or_icmp_bad_proof.select_or_icmp_bad_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 3)) (LLVM.or e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 3)) (LLVM.or e_2 (const? 32 3)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_lshr_icmp_const_proof.select_lshr_icmp_const_thm_1 (e : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 31)) (lshr e (const? 32 5)) (const? 32 0) ⊑ lshr e (const? 32 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_lshr_icmp_const_reordered_proof.select_lshr_icmp_const_reordered_thm_1 (e : IntW 32) :
  select (icmp IntPred.ult e (const? 32 32)) (const? 32 0) (lshr e (const? 32 5)) ⊑ lshr e (const? 32 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_exact_lshr_icmp_const_proof.select_exact_lshr_icmp_const_thm_1 (e : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 31)) (lshr e (const? 32 5) { «exact» := true }) (const? 32 0) ⊑
    lshr e (const? 32 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_sub_icmp_bad_proof.select_sub_icmp_bad_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (sub e e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 0)) (sub (const? 32 0) e_2) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_sub_icmp_bad_2_proof.select_sub_icmp_bad_2_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 1)) (sub e_2 e) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 1)) (add e_2 (const? 32 (-1))) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_shl_icmp_bad_proof.select_shl_icmp_bad_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 1)) (shl e_2 e) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 1)) (shl e_2 (const? 32 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_lshr_icmp_bad_proof.select_lshr_icmp_bad_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 1)) (lshr e_2 e) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 1)) (lshr e_2 (const? 32 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_ashr_icmp_bad_proof.select_ashr_icmp_bad_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 1)) (ashr e_2 e) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 1)) (ashr e_2 (const? 32 1)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_replace_one_use_proof.select_replace_one_use_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (sub e e_1) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 0)) (sub (const? 32 0) e_1) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_replace_nested_proof.select_replace_nested_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (add (sub e_1 e) e_2) e_1 ⊑
    add e_1 (select (icmp IntPred.eq e (const? 32 0)) e_2 (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_replace_nested_no_simplify_proof.select_replace_nested_no_simplify_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 1)) (add (sub e_1 e) e_2) e_1 ⊑
    select (icmp IntPred.eq e (const? 32 1)) (add (add e_1 (const? 32 (-1))) e_2) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_replace_udiv_non_speculatable_proof.select_replace_udiv_non_speculatable_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq e (const? 32 0)) (LLVM.udiv e_1 e) e_1 ⊑ e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
