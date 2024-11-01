
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphsignmask_proof
theorem cmp_x_and_negp2_with_eq_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and e (const? 8 (-2))) (const? 8 (-128)) ⊑
    icmp IntPredicate.slt e (const? 8 (-126)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


