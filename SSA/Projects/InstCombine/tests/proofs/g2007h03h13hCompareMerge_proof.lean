
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section g2007h03h13hCompareMerge_proof
theorem test_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.eq e_1 e) ⊑ icmp IntPredicate.sle e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.slt e_1 e) (const? 1 1) (icmp IntPredicate.eq e_1 e) ⊑ icmp IntPredicate.sle e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


