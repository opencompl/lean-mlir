
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section g2007h05h10hicmphor_proof
theorem test_thm (e : IntW 32) :
  LLVM.or (icmp IntPred.ugt e (const? 32 255)) (icmp IntPred.sgt e (const? 32 255)) ⊑
    icmp IntPred.ugt e (const? 32 255) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_logical_thm (e : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 255)) (const? 1 1) (icmp IntPred.sgt e (const? 32 255)) ⊑
    icmp IntPred.ugt e (const? 32 255) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
