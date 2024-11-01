
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2007h06h21hDivCompareMiscomp_proof
theorem test_thm (e : IntW 32) :
  icmp IntPredicate.ult (LLVM.udiv e (const? 4)) (const? 1073741824) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


