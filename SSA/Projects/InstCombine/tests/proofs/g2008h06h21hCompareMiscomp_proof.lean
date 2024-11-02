
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h06h21hCompareMiscomp_proof
theorem test_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ugt e (const? 32 13)) (icmp IntPredicate.eq e (const? 32 15)) ⊑
    icmp IntPredicate.eq e (const? 32 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem test_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt e (const? 32 13)) (icmp IntPredicate.eq e (const? 32 15)) (const? 1 0) ⊑
    icmp IntPredicate.eq e (const? 32 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


