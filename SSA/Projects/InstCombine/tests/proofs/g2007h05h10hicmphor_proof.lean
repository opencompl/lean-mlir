
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section g2007h05h10hicmphor_proof
theorem test_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.ugt e (const? 32 255)) (icmp IntPredicate.sgt e (const? 32 255)) ⊑
    icmp IntPredicate.ugt e (const? 32 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt e (const? 32 255)) (const? 1 1) (icmp IntPredicate.sgt e (const? 32 255)) ⊑
    icmp IntPredicate.ugt e (const? 32 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


