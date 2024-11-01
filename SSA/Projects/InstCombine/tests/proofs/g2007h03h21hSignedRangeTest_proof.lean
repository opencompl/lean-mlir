
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2007h03h21hSignedRangeTest_proof
theorem test_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.sdiv e (const? 12)) (const? (-6)) ⊑
    icmp IntPredicate.ult (add e (const? 71)) (const? (-12)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


