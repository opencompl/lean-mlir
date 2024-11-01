
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2007h05h10hicmphor_proof
theorem test_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.ugt e (const? 32 255)) (icmp IntPredicate.sgt e (const? 32 255)) ⊑
    icmp IntPredicate.ugt e (const? 32 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt e (const? 32 255)) (const? 1 1) (icmp IntPredicate.sgt e (const? 32 255)) ⊑
    icmp IntPredicate.ugt e (const? 32 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


