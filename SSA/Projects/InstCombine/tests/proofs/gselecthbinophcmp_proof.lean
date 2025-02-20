
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gselecthbinophcmp_proof
theorem select_xor_icmp_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 0)) (LLVM.xor e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_xor_icmp2_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ne e_2 (const? 32 0)) e_1 (LLVM.xor e_2 e) ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_xor_icmp_meta_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 0)) (LLVM.xor e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_mul_icmp_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 1)) (mul e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 1)) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_add_icmp_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 0)) (add e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_or_icmp_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 0)) (LLVM.or e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_and_icmp_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 (-1))) (LLVM.and e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 (-1))) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_xor_inv_icmp_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 0)) (LLVM.xor e_1 e_2) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_sub_icmp_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 0)) (sub e_1 e_2) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_lshr_icmp_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 0)) (lshr e_1 e_2) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_udiv_icmp_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 1)) (LLVM.udiv e_1 e_2) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 1)) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_xor_icmp_bad_3_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 3)) (LLVM.xor e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 3)) (LLVM.xor e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_xor_icmp_bad_5_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ne e_2 (const? 32 0)) (LLVM.xor e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) e (LLVM.xor e_2 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_xor_icmp_bad_6_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ne e_2 (const? 32 1)) e_1 (LLVM.xor e_2 e) ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 1)) (LLVM.xor e (const? 32 1)) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_mul_icmp_bad_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 3)) (mul e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 3)) (mul e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_add_icmp_bad_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 1)) (add e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 1)) (add e_1 (const? 32 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_and_icmp_zero_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 0)) (LLVM.and e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) (const? 32 0) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_or_icmp_bad_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 3)) (LLVM.or e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 3)) (LLVM.or e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_lshr_icmp_const_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt e (const? 32 31)) (lshr e (const? 32 5)) (const? 32 0) ⊑ lshr e (const? 32 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_lshr_icmp_const_reordered_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 32 32)) (const? 32 0) (lshr e (const? 32 5)) ⊑ lshr e (const? 32 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_exact_lshr_icmp_const_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt e (const? 32 31)) (lshr e (const? 32 5) { «exact» := true }) (const? 32 0) ⊑
    lshr e (const? 32 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_sub_icmp_bad_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 0)) (sub e_2 e_1) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 0)) (sub (const? 32 0) e_1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_sub_icmp_bad_2_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 1)) (sub e_1 e_2) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 1)) (add e_1 (const? 32 (-1))) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_shl_icmp_bad_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 1)) (shl e_1 e_2) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 1)) (shl e_1 (const? 32 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_lshr_icmp_bad_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 1)) (lshr e_1 e_2) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 1)) (lshr e_1 (const? 32 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_ashr_icmp_bad_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 1)) (ashr e_1 e_2) e ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 1)) (ashr e_1 (const? 32 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_replace_one_use_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq e_1 (const? 32 0)) (sub e_1 e) e ⊑
    select (icmp IntPredicate.eq e_1 (const? 32 0)) (sub (const? 32 0) e) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_replace_nested_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 0)) (add (sub e_1 e_2) e) e_1 ⊑
    add e_1 (select (icmp IntPredicate.eq e_2 (const? 32 0)) e (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_replace_nested_no_simplify_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq e_2 (const? 32 1)) (add (sub e_1 e_2) e) e_1 ⊑
    select (icmp IntPredicate.eq e_2 (const? 32 1)) (add (add e_1 (const? 32 (-1))) e) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_replace_udiv_non_speculatable_thm (e e_1 : IntW 32) : select (icmp IntPredicate.eq e_1 (const? 32 0)) (LLVM.udiv e e_1) e ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
