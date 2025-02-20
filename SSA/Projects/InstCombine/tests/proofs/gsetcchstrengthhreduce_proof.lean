
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gsetcchstrengthhreduce_proof
theorem test1_thm (e : IntW 32) :
  icmp IntPredicate.uge e (const? 32 1) ⊑ icmp IntPredicate.ne e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 32) :
  icmp IntPredicate.ugt e (const? 32 0) ⊑ icmp IntPredicate.ne e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e : IntW 8) :
  icmp IntPredicate.sge e (const? 8 (-127)) ⊑ icmp IntPredicate.ne e (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e : IntW 8) :
  icmp IntPredicate.sle e (const? 8 126) ⊑ icmp IntPredicate.ne e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 8) :
  icmp IntPredicate.slt e (const? 8 127) ⊑ icmp IntPredicate.ne e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
