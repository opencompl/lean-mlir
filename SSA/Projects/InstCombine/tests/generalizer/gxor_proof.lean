
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gxor_proof
theorem test0_proof.test0_thm_1 (e : IntW 1) : LLVM.xor e (const? 1 0) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test1_proof.test1_thm_1 (e : IntW 32) : LLVM.xor e (const? 32 0) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e : IntW 1) : LLVM.xor e e ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 32) : LLVM.xor e e ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e : IntW 32) : LLVM.xor e (LLVM.xor (const? 32 (-1)) e) ⊑ const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e : IntW 32) :
  LLVM.xor (LLVM.or e (const? 32 123)) (const? 32 123) ⊑ LLVM.and e (const? 32 (-124)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test6_proof.test6_thm_1 (e : IntW 8) : LLVM.xor (LLVM.xor e (const? 8 17)) (const? 8 17) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e (const? 32 7)) (LLVM.and e_1 (const? 32 128)) ⊑
    LLVM.or (LLVM.and e (const? 32 7)) (LLVM.and e_1 (const? 32 128)) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.xor e (const? 8 123)) (const? 8 34) ⊑ icmp IntPred.eq e (const? 8 89) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10_proof.test10_thm_1 (e : IntW 8) :
  LLVM.xor (LLVM.and e (const? 8 3)) (const? 8 4) ⊑
    LLVM.or (LLVM.and e (const? 8 3)) (const? 8 4) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11_proof.test11_thm_1 (e : IntW 8) :
  LLVM.xor (LLVM.or e (const? 8 12)) (const? 8 4) ⊑
    LLVM.or (LLVM.and e (const? 8 (-13))) (const? 8 8) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test12_proof.test12_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.xor e (const? 8 4)) (const? 8 0) ⊑ icmp IntPred.ne e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test18_proof.test18_thm_1 (e : IntW 32) :
  sub (const? 32 123) (LLVM.xor e (const? 32 (-1))) ⊑ add e (const? 32 124) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test19_proof.test19_thm_1 (e e_1 : IntW 32) : LLVM.xor (LLVM.xor e e_1) e ⊑ e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test22_proof.test22_thm_1 (e : IntW 1) :
  LLVM.xor (zext 32 (LLVM.xor e (const? 1 1))) (const? 32 1) ⊑ zext 32 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_zext_xor_sandwich_proof.fold_zext_xor_sandwich_thm_1 (e : IntW 1) :
  LLVM.xor (zext 32 (LLVM.xor e (const? 1 1))) (const? 32 2) ⊑ LLVM.xor (zext 32 e) (const? 32 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test23_proof.test23_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.xor e_1 e) e ⊑ icmp IntPred.eq e_1 (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test24_proof.test24_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.xor e_1 e) e ⊑ icmp IntPred.ne e_1 (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test25_proof.test25_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e) e ⊑ LLVM.and e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test27_proof.test27_thm_1 (e e_1 e_2 : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.xor e_2 e) (LLVM.xor e_2 e_1)) ⊑ zext 32 (icmp IntPred.eq e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test28_proof.test28_thm_1 (e : IntW 32) :
  LLVM.xor (add e (const? 32 (-2147483647))) (const? 32 (-2147483648)) ⊑ add e (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test28_sub_proof.test28_sub_thm_1 (e : IntW 32) :
  LLVM.xor (sub (const? 32 (-2147483647)) e) (const? 32 (-2147483648)) ⊑ sub (const? 32 1) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test29_proof.test29_thm_1 (e : IntW 1) :
  LLVM.xor (select e (const? 32 1000) (const? 32 10)) (const? 32 123) ⊑
    select e (const? 32 915) (const? 32 113) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_commute1_proof.or_xor_commute1_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e_1) (LLVM.or (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e)) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_commute2_proof.or_xor_commute2_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.udiv (const? 32 42) e) (LLVM.udiv (const? 32 42) e_1)) (LLVM.udiv (const? 32 42) e_1) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_commute3_proof.or_xor_commute3_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e)) (LLVM.udiv (const? 32 42) e_1) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_xor_commute4_proof.or_xor_commute4_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e_1) (LLVM.or (LLVM.udiv (const? 32 42) e) (LLVM.udiv (const? 32 42) e_1)) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_xor_commute1_proof.and_xor_commute1_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e_1) (LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e)) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 42) e) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_xor_commute2_proof.and_xor_commute2_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.udiv (const? 32 42) e_1)) (LLVM.udiv (const? 32 42) e_1) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 42) e) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_xor_commute3_proof.and_xor_commute3_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e)) (LLVM.udiv (const? 32 42) e_1) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 42) e) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_xor_commute4_proof.and_xor_commute4_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e_1) (LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.udiv (const? 32 42) e_1)) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 42) e) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_xor_proof.or_or_xor_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.or e_2 e) (LLVM.or e_2 e_1) ⊑ LLVM.and (LLVM.xor e e_1) (LLVM.xor e_2 (const? 4 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_xor_commute1_proof.or_or_xor_commute1_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.or e e_2) (LLVM.or e_2 e_1) ⊑ LLVM.and (LLVM.xor e e_1) (LLVM.xor e_2 (const? 4 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_xor_commute2_proof.or_or_xor_commute2_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.or e_2 e) (LLVM.or e_1 e_2) ⊑ LLVM.and (LLVM.xor e e_1) (LLVM.xor e_2 (const? 4 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_is_canonical_proof.not_is_canonical_thm_1 (e e_1 : IntW 32) :
  shl (add (LLVM.xor e (const? 32 1073741823)) e_1) (const? 32 2) ⊑
    shl (add e_1 (LLVM.xor e (const? 32 (-1)))) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_shl_proof.not_shl_thm_1 (e : IntW 8) :
  LLVM.xor (shl e (const? 8 7)) (const? 8 (-128)) ⊑ shl (LLVM.xor e (const? 8 (-1))) (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_lshr_proof.not_lshr_thm_1 (e : IntW 8) :
  LLVM.xor (lshr e (const? 8 5)) (const? 8 7) ⊑ lshr (LLVM.xor e (const? 8 (-1))) (const? 8 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_not_proof.ashr_not_thm_1 (e : IntW 8) :
  ashr (LLVM.xor e (const? 8 (-1))) (const? 8 5) ⊑ LLVM.xor (ashr e (const? 8 5)) (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_andn_commute2_proof.xor_andn_commute2_thm_1 (e e_1 : IntW 33) :
  LLVM.xor (LLVM.and (LLVM.udiv (const? 33 42) e_1) (LLVM.xor e (const? 33 (-1)))) e ⊑
    LLVM.or e (LLVM.udiv (const? 33 42) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_andn_commute3_proof.xor_andn_commute3_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e) (LLVM.and (LLVM.xor (LLVM.udiv (const? 32 42) e) (const? 32 (-1))) e_1) ⊑
    LLVM.or (LLVM.udiv (const? 32 42) e) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_andn_commute4_proof.xor_andn_commute4_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e)
      (LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 42) e) (const? 32 (-1)))) ⊑
    LLVM.or (LLVM.udiv (const? 32 42) e) (LLVM.udiv (const? 32 42) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_orn_commute1_proof.xor_orn_commute1_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (LLVM.udiv (const? 8 42) e) (LLVM.or (LLVM.xor (LLVM.udiv (const? 8 42) e) (const? 8 (-1))) e_1) ⊑
    LLVM.xor (LLVM.and (LLVM.udiv (const? 8 42) e) e_1) (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_xor_ashr_lshr_proof.tryFactorization_xor_ashr_lshr_thm_1 (e : IntW 32) :
  LLVM.xor (ashr (const? 32 (-3)) e) (lshr (const? 32 5) e) ⊑ ashr (const? 32 (-8)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_xor_lshr_ashr_proof.tryFactorization_xor_lshr_ashr_thm_1 (e : IntW 32) :
  LLVM.xor (lshr (const? 32 5) e) (ashr (const? 32 (-3)) e) ⊑ ashr (const? 32 (-8)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_xor_lshr_lshr_proof.tryFactorization_xor_lshr_lshr_thm_1 (e : IntW 32) :
  LLVM.xor (lshr (const? 32 (-3)) e) (lshr (const? 32 5) e) ⊑ lshr (const? 32 (-8)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem tryFactorization_xor_ashr_ashr_proof.tryFactorization_xor_ashr_ashr_thm_1 (e : IntW 32) :
  LLVM.xor (ashr (const? 32 (-3)) e) (ashr (const? 32 (-5)) e) ⊑ lshr (const? 32 6) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR96857_xor_without_noundef_proof.PR96857_xor_without_noundef_thm_1 (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.and e_2 e) (LLVM.and (LLVM.xor e_2 (const? 4 (-1))) e_1) ⊑
    LLVM.or (LLVM.and e_2 e) (LLVM.and e_1 (LLVM.xor e_2 (const? 4 (-1)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_disjoint_with_xor_proof.or_disjoint_with_xor_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or e e_1 { «disjoint» := true }) e ⊑ e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_with_or_disjoint_ab_proof.xor_with_or_disjoint_ab_thm_1 (e e_1 : IntW 32) :
  LLVM.xor e (LLVM.or e e_1 { «disjoint» := true }) ⊑ e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_with_or_disjoint_ba_proof.xor_with_or_disjoint_ba_thm_1 (e e_1 : IntW 32) :
  LLVM.xor e_1 (LLVM.or e_1 e { «disjoint» := true }) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_or_disjoint_or_proof.select_or_disjoint_or_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  add (LLVM.or (select e_1 (const? 32 0) (const? 32 4)) (shl e (const? 32 4)) { «disjoint» := true }) (const? 32 4) ⊑
    add (LLVM.or (select e_1 (const? 32 0) (const? 32 4)) (shl e (const? 32 4)) { «disjoint» := true }) (const? 32 4)
      { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
