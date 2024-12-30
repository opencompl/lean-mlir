
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section g2007h03h21hSignedRangeTest_proof
theorem test_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.sdiv e (const? 32 12)) (const? 32 (-6)) ⊑
    icmp IntPredicate.ult (add e (const? 32 71)) (const? 32 (-12)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


