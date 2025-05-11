
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gapinthsub_proof
theorem test1_thm (e : IntW 23) : sub e e ⊑ const? 23 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 47) : sub e (const? 47 0) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e : IntW 97) : sub (const? 97 0) (sub (const? 97 0) e) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e e_1 : IntW 108) : sub e_1 (sub (const? 108 0) e) ⊑ add e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e e_1 e_2 : IntW 19) : sub e_2 (sub e_1 e) ⊑ add (sub e e_1) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e e_1 : IntW 57) : sub e_1 (LLVM.and e_1 e) ⊑ LLVM.and e_1 (LLVM.xor e (const? 57 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 77) : sub (const? 77 (-1)) e ⊑ LLVM.xor e (const? 77 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test8_thm (e : IntW 27) : sub (mul (const? 27 9) e) e ⊑ shl e (const? 27 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 42) : sub e (mul (const? 42 3) e) ⊑ mul e (const? 42 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_thm (e e_1 : IntW 9) :
  icmp IntPredicate.ne (sub e_1 e) (const? 9 0) ⊑ icmp IntPredicate.ne e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test12_thm (e : IntW 43) : sub (const? 43 0) (ashr e (const? 43 42)) ⊑ lshr e (const? 43 42) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test13_thm (e : IntW 79) : sub (const? 79 0) (lshr e (const? 79 78)) ⊑ ashr e (const? 79 78) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test16_thm (e : IntW 51) :
  sub (const? 51 0) (LLVM.sdiv e (const? 51 1123)) ⊑ LLVM.sdiv e (const? 51 (-1123)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test18_thm (e : IntW 128) : sub (shl e (const? 128 2)) (shl e (const? 128 2)) ⊑ const? 128 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19_thm (e e_1 : IntW 39) : add (sub e_1 e) e ⊑ e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test20_thm (e e_1 : IntW 33) :
  icmp IntPredicate.ne (sub e_1 e) e_1 ⊑ icmp IntPredicate.ne e (const? 33 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test21_thm (e e_1 : IntW 256) :
  icmp IntPredicate.ne (sub e_1 e) e_1 ⊑ icmp IntPredicate.ne e (const? 256 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
