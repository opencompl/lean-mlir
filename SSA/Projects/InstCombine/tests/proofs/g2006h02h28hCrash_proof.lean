
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2006h02h28hCrash_proof
theorem test_thm : zext 32 (icmp IntPredicate.eq (const? 32 1) (const? 32 2)) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


