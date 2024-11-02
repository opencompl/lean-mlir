
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h01h13hAndCmpCmp_proof
theorem test_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ne e (const? 32 34)) (icmp IntPredicate.sgt e (const? 32 (-1))) (const? 1 0) ⊑
    LLVM.and (icmp IntPredicate.ne e (const? 32 34)) (icmp IntPredicate.sgt e (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


