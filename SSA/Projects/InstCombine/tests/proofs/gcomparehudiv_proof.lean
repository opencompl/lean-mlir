
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gcomparehudiv_proof
theorem test1_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.udiv e_1 e) (const? 32 0) ⊑ icmp IntPred.ugt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 32) :
  icmp IntPred.eq (LLVM.udiv (const? 32 64) e) (const? 32 0) ⊑ icmp IntPred.ugt e (const? 32 64) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.udiv e_1 e) (const? 32 0) ⊑ icmp IntPred.ule e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e : IntW 32) :
  icmp IntPred.ne (LLVM.udiv (const? 32 64) e) (const? 32 0) ⊑ icmp IntPred.ult e (const? 32 65) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 32) :
  icmp IntPred.ne (LLVM.udiv (const? 32 (-1)) e) (const? 32 0) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e : IntW 32) :
  icmp IntPred.ugt (LLVM.udiv (const? 32 5) e) (const? 32 0) ⊑ icmp IntPred.ult e (const? 32 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 32) :
  icmp IntPred.ugt (LLVM.udiv (const? 32 8) e) (const? 32 8) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test8_thm (e : IntW 32) :
  icmp IntPred.ugt (LLVM.udiv (const? 32 4) e) (const? 32 3) ⊑ icmp IntPred.ult e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 32) :
  icmp IntPred.ugt (LLVM.udiv (const? 32 4) e) (const? 32 2) ⊑ icmp IntPred.ult e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e : IntW 32) :
  icmp IntPred.ugt (LLVM.udiv (const? 32 4) e) (const? 32 1) ⊑ icmp IntPred.ult e (const? 32 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_thm (e : IntW 32) :
  icmp IntPred.ult (LLVM.udiv (const? 32 4) e) (const? 32 1) ⊑ icmp IntPred.ugt e (const? 32 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test12_thm (e : IntW 32) :
  icmp IntPred.ult (LLVM.udiv (const? 32 4) e) (const? 32 2) ⊑ icmp IntPred.ugt e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test13_thm (e : IntW 32) :
  icmp IntPred.ult (LLVM.udiv (const? 32 4) e) (const? 32 3) ⊑ icmp IntPred.ugt e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test14_thm (e : IntW 32) :
  icmp IntPred.ult (LLVM.udiv (const? 32 4) e) (const? 32 4) ⊑ icmp IntPred.ugt e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15_thm (e : IntW 32) :
  icmp IntPred.ugt (LLVM.udiv (const? 32 4) e) (const? 32 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test16_thm (e : IntW 32) :
  icmp IntPred.ult (LLVM.udiv (const? 32 4) e) (const? 32 (-1)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
