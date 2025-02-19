
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthshift_proof
theorem test6_thm (e : IntW 55) : mul (shl e (const? 55 1)) (const? 55 3) ⊑ mul e (const? 55 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6a_thm (e : IntW 55) : shl (mul e (const? 55 3)) (const? 55 1) ⊑ mul e (const? 55 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 8) : ashr (const? 29 (-1)) (zext 29 e) ⊑ const? 29 (-1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test8_thm (e : IntW 7) : shl (shl e (const? 7 4)) (const? 7 3) ⊑ const? 7 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 17) : lshr (shl e (const? 17 16)) (const? 17 16) ⊑ LLVM.and e (const? 17 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e : IntW 19) :
  shl (lshr e (const? 19 18)) (const? 19 18) ⊑ LLVM.and e (const? 19 (-262144)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem multiuse_lshr_lshr_thm (e : IntW 9) :
  mul (lshr e (const? 9 2)) (lshr (lshr e (const? 9 2)) (const? 9 3)) ⊑
    mul (lshr e (const? 9 2)) (lshr e (const? 9 5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem multiuse_shl_shl_thm (e : IntW 42) :
  mul (shl e (const? 42 8)) (shl (shl e (const? 42 8)) (const? 42 9)) ⊑
    mul (shl e (const? 42 8)) (shl e (const? 42 17)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_thm (e : IntW 23) :
  shl (lshr (mul e (const? 23 3)) (const? 23 11)) (const? 23 12) ⊑
    LLVM.and (mul e (const? 23 6)) (const? 23 (-4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test12_thm (e : IntW 47) : shl (ashr e (const? 47 8)) (const? 47 8) ⊑ LLVM.and e (const? 47 (-256)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test13_thm (e : IntW 18) :
  shl (ashr (mul e (const? 18 3)) (const? 18 8)) (const? 18 9) ⊑
    LLVM.and (mul e (const? 18 6)) (const? 18 (-512)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test14_thm (e : IntW 35) :
  shl (LLVM.or (lshr e (const? 35 4)) (const? 35 1234)) (const? 35 4) ⊑
    LLVM.or (LLVM.and e (const? 35 (-19760))) (const? 35 19744) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test14a_thm (e : IntW 79) :
  lshr (LLVM.and (shl e (const? 79 4)) (const? 79 1234)) (const? 79 4) ⊑ LLVM.and e (const? 79 77) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15_thm (e : IntW 1) :
  shl (select e (const? 45 3) (const? 45 1)) (const? 45 2) ⊑ select e (const? 45 12) (const? 45 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15a_thm (e : IntW 1) :
  shl (const? 53 64) (zext 53 (select e (const? 8 3) (const? 8 1))) ⊑ select e (const? 53 512) (const? 53 128) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test16_thm (e : IntW 84) :
  icmp IntPredicate.ne (LLVM.and (ashr e (const? 84 4)) (const? 84 1)) (const? 84 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 84 16)) (const? 84 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test17_thm (e : IntW 106) :
  icmp IntPredicate.eq (lshr e (const? 106 3)) (const? 106 1234) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 106 (-8))) (const? 106 9872) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test18_thm (e : IntW 11) : icmp IntPredicate.eq (lshr e (const? 11 10)) (const? 11 123) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19_thm (e : IntW 37) :
  icmp IntPredicate.eq (ashr e (const? 37 2)) (const? 37 0) ⊑ icmp IntPredicate.ult e (const? 37 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19a_thm (e : IntW 39) :
  icmp IntPredicate.eq (ashr e (const? 39 2)) (const? 39 (-1)) ⊑ icmp IntPredicate.ugt e (const? 39 (-5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test20_thm (e : IntW 13) : icmp IntPredicate.eq (ashr e (const? 13 12)) (const? 13 123) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test21_thm (e : IntW 12) :
  icmp IntPredicate.eq (shl e (const? 12 6)) (const? 12 (-128)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 12 63)) (const? 12 62) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test22_thm (e : IntW 14) :
  icmp IntPredicate.eq (shl e (const? 14 7)) (const? 14 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 14 127)) (const? 14 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test23_thm (e : IntW 44) : trunc 11 (ashr (shl e (const? 44 33)) (const? 44 33)) ⊑ trunc 11 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_lshr_eq_amt_multi_use_thm (e : IntW 44) :
  add (shl e (const? 44 33)) (lshr (shl e (const? 44 33)) (const? 44 33)) ⊑
    LLVM.or (shl e (const? 44 33)) (LLVM.and e (const? 44 2047)) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_shl_eq_amt_multi_use_thm (e : IntW 43) :
  mul (lshr e (const? 43 23)) (shl (lshr e (const? 43 23)) (const? 43 23)) ⊑
    mul (lshr e (const? 43 23)) (LLVM.and e (const? 43 (-8388608))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test25_thm (e e_1 : IntW 37) :
  shl (add (lshr e_1 (const? 37 17)) (lshr e (const? 37 17))) (const? 37 17) ⊑
    LLVM.and (add e (LLVM.and e_1 (const? 37 (-131072)))) (const? 37 (-131072)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


