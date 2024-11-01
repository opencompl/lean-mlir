
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h11h01hSRemDemandedBits_proof
theorem foo_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.srem e (const? 32 (-1))) (const? 32 0) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


