
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2006h10h19hSignedToUnsignedCastAndConsth2_proof
theorem eq_signed_to_small_unsigned_thm (e : IntW 8) :
  icmp IntPredicate.eq (sext 32 e) (const? 17) ⊑ icmp IntPredicate.eq e (const? 17) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


