
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h07h08hShiftOneAndOne_proof
theorem PR2330_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl (const? 1) e) (const? 1)) (const? 0) ⊑ icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


