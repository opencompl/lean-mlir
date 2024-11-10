
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section g2008h10h11hDivCompareFold_proof
theorem x_thm (e : IntW 32) :
  icmp IntPredicate.slt (LLVM.sdiv e (const? 32 65536)) (const? 32 (-65536)) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


