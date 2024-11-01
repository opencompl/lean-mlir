
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2005h06h16hRangeCrash_proof
theorem test_thm : icmp IntPredicate.eq (LLVM.sdiv (const? 0) (const? (-2147483648))) (const? 0) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


