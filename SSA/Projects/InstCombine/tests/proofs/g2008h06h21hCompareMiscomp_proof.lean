
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section g2008h06h21hCompareMiscomp_proof
theorem test_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ugt e (const? 32 13)) (icmp IntPred.eq e (const? 32 15)) ⊑
    icmp IntPred.eq e (const? 32 15) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_logical_thm (e : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 13)) (icmp IntPred.eq e (const? 32 15)) (const? 1 0) ⊑
    icmp IntPred.eq e (const? 32 15) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
