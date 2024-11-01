
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h10h11hDivCompareFold_proof
theorem x_thm (e : IntW 32) :
  icmp IntPredicate.slt (LLVM.sdiv e (const? 65536)) (const? (-65536)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


