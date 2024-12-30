
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gxor_proof
theorem test0_thm (e : IntW 1) : LLVM.xor e (const? 1 0) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test1_thm (e : IntW 32) : LLVM.xor e (const? 32 0) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 1) : LLVM.xor e e ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e : IntW 32) : LLVM.xor e e ⊑ const? 32 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e : IntW 32) : LLVM.xor e (LLVM.xor (const? 32 (-1)) e) ⊑ const? 32 (-1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 32) :
  LLVM.xor (LLVM.or e (const? 32 123)) (const? 32 123) ⊑ LLVM.and e (const? 32 (-124)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e : IntW 8) : LLVM.xor (LLVM.xor e (const? 8 17)) (const? 8 17) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e_1 (const? 32 7)) (LLVM.and e (const? 32 128)) ⊑
    LLVM.or (LLVM.and e_1 (const? 32 7)) (LLVM.and e (const? 32 128)) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.xor e (const? 8 123)) (const? 8 34) ⊑ icmp IntPredicate.eq e (const? 8 89) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e : IntW 8) :
  LLVM.xor (LLVM.and e (const? 8 3)) (const? 8 4) ⊑
    LLVM.or (LLVM.and e (const? 8 3)) (const? 8 4) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_thm (e : IntW 8) :
  LLVM.xor (LLVM.or e (const? 8 12)) (const? 8 4) ⊑
    LLVM.or (LLVM.and e (const? 8 (-13))) (const? 8 8) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test12_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.xor e (const? 8 4)) (const? 8 0) ⊑ icmp IntPredicate.ne e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test18_thm (e : IntW 32) : sub (const? 32 123) (LLVM.xor e (const? 32 (-1))) ⊑ add e (const? 32 124) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19_thm (e e_1 : IntW 32) : LLVM.xor (LLVM.xor e_1 e) e_1 ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test22_thm (e : IntW 1) : LLVM.xor (zext 32 (LLVM.xor e (const? 1 1))) (const? 32 1) ⊑ zext 32 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_zext_xor_sandwich_thm (e : IntW 1) :
  LLVM.xor (zext 32 (LLVM.xor e (const? 1 1))) (const? 32 2) ⊑ LLVM.xor (zext 32 e) (const? 32 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test23_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.xor e_1 e) e ⊑ icmp IntPredicate.eq e_1 (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test24_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.xor e_1 e) e ⊑ icmp IntPredicate.ne e_1 (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test25_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) e) e ⊑ LLVM.and e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test27_thm (e e_1 e_2 : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.xor e_2 e_1) (LLVM.xor e_2 e)) ⊑ zext 32 (icmp IntPredicate.eq e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test28_thm (e : IntW 32) :
  LLVM.xor (add e (const? 32 (-2147483647))) (const? 32 (-2147483648)) ⊑ add e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test28_sub_thm (e : IntW 32) :
  LLVM.xor (sub (const? 32 (-2147483647)) e) (const? 32 (-2147483648)) ⊑ sub (const? 32 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test29_thm (e : IntW 1) :
  LLVM.xor (select e (const? 32 1000) (const? 32 10)) (const? 32 123) ⊑
    select e (const? 32 915) (const? 32 113) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_commute1_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e_1) (LLVM.or (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e)) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_commute2_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e)) (LLVM.udiv (const? 32 42) e) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 42) e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_commute3_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e)) (LLVM.udiv (const? 32 42) e_1) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_xor_commute4_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e_1) (LLVM.or (LLVM.udiv (const? 32 42) e) (LLVM.udiv (const? 32 42) e_1)) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_commute1_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e_1) (LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e)) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 42) e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_commute2_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e)) (LLVM.udiv (const? 32 42) e) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_commute3_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e)) (LLVM.udiv (const? 32 42) e_1) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 42) e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_xor_commute4_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e_1) (LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.udiv (const? 32 42) e_1)) ⊑
    LLVM.and (LLVM.udiv (const? 32 42) e_1) (LLVM.xor (LLVM.udiv (const? 32 42) e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_or_xor_thm (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.or e_2 e_1) (LLVM.or e_2 e) ⊑ LLVM.and (LLVM.xor e_1 e) (LLVM.xor e_2 (const? 4 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_or_xor_commute1_thm (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.or e_2 e_1) (LLVM.or e_1 e) ⊑ LLVM.and (LLVM.xor e_2 e) (LLVM.xor e_1 (const? 4 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_or_xor_commute2_thm (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.or e_2 e_1) (LLVM.or e e_2) ⊑ LLVM.and (LLVM.xor e_1 e) (LLVM.xor e_2 (const? 4 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_is_canonical_thm (e e_1 : IntW 32) :
  shl (add (LLVM.xor e_1 (const? 32 1073741823)) e) (const? 32 2) ⊑
    shl (add e (LLVM.xor e_1 (const? 32 (-1)))) (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_shl_thm (e : IntW 8) :
  LLVM.xor (shl e (const? 8 7)) (const? 8 (-128)) ⊑ shl (LLVM.xor e (const? 8 (-1))) (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_lshr_thm (e : IntW 8) :
  LLVM.xor (lshr e (const? 8 5)) (const? 8 7) ⊑ lshr (LLVM.xor e (const? 8 (-1))) (const? 8 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_not_thm (e : IntW 8) :
  ashr (LLVM.xor e (const? 8 (-1))) (const? 8 5) ⊑ LLVM.xor (ashr e (const? 8 5)) (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_andn_commute2_thm (e e_1 : IntW 33) :
  LLVM.xor (LLVM.and (LLVM.udiv (const? 33 42) e_1) (LLVM.xor e (const? 33 (-1)))) e ⊑
    LLVM.or e (LLVM.udiv (const? 33 42) e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_andn_commute3_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e_1) (LLVM.and (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (const? 32 (-1))) e) ⊑
    LLVM.or (LLVM.udiv (const? 32 42) e_1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_andn_commute4_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.udiv (const? 32 42) e_1)
      (LLVM.and (LLVM.udiv (const? 32 42) e) (LLVM.xor (LLVM.udiv (const? 32 42) e_1) (const? 32 (-1)))) ⊑
    LLVM.or (LLVM.udiv (const? 32 42) e_1) (LLVM.udiv (const? 32 42) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_orn_commute1_thm (e e_1 : IntW 8) :
  LLVM.xor (LLVM.udiv (const? 8 42) e_1) (LLVM.or (LLVM.xor (LLVM.udiv (const? 8 42) e_1) (const? 8 (-1))) e) ⊑
    LLVM.xor (LLVM.and (LLVM.udiv (const? 8 42) e_1) e) (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_xor_ashr_lshr_thm (e : IntW 32) :
  LLVM.xor (ashr (const? 32 (-3)) e) (lshr (const? 32 5) e) ⊑ ashr (const? 32 (-8)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_xor_lshr_ashr_thm (e : IntW 32) :
  LLVM.xor (lshr (const? 32 5) e) (ashr (const? 32 (-3)) e) ⊑ ashr (const? 32 (-8)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_xor_lshr_lshr_thm (e : IntW 32) :
  LLVM.xor (lshr (const? 32 (-3)) e) (lshr (const? 32 5) e) ⊑ lshr (const? 32 (-8)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem tryFactorization_xor_ashr_ashr_thm (e : IntW 32) :
  LLVM.xor (ashr (const? 32 (-3)) e) (ashr (const? 32 (-5)) e) ⊑ lshr (const? 32 6) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR96857_xor_with_noundef_thm (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.and e_2 e_1) (LLVM.and (LLVM.xor e_2 (const? 4 (-1))) e) ⊑
    LLVM.or (LLVM.and e_2 e_1) (LLVM.and e (LLVM.xor e_2 (const? 4 (-1)))) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR96857_xor_without_noundef_thm (e e_1 e_2 : IntW 4) :
  LLVM.xor (LLVM.and e_2 e_1) (LLVM.and (LLVM.xor e_2 (const? 4 (-1))) e) ⊑
    LLVM.or (LLVM.and e_2 e_1) (LLVM.and e (LLVM.xor e_2 (const? 4 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_disjoint_with_xor_thm (e e_1 : IntW 32) : LLVM.xor (LLVM.or e_1 e { «disjoint» := true }) e_1 ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_with_or_disjoint_ab_thm (e e_1 : IntW 32) : LLVM.xor e_1 (LLVM.or e_1 e { «disjoint» := true }) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_with_or_disjoint_ba_thm (e e_1 : IntW 32) : LLVM.xor e_1 (LLVM.or e_1 e { «disjoint» := true }) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_or_disjoint_or_thm (e : IntW 32) (e_1 : IntW 1) :
  add (LLVM.or (select e_1 (const? 32 0) (const? 32 4)) (shl e (const? 32 4)) { «disjoint» := true }) (const? 32 4) ⊑
    add (LLVM.or (select e_1 (const? 32 0) (const? 32 4)) (shl e (const? 32 4)) { «disjoint» := true }) (const? 32 4)
      { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


