
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2007h11h15hCompareMiscomp_proof
theorem test_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt e (const? (-1))) (icmp IntPredicate.eq e (const? 1)) ⊑
    icmp IntPredicate.eq e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt e (const? (-1))) (icmp IntPredicate.eq e (const? 1)) (const? 0) ⊑
    icmp IntPredicate.eq e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


