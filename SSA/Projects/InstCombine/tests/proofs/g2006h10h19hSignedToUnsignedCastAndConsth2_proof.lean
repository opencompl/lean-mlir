
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section g2006h10h19hSignedToUnsignedCastAndConsth2_proof
theorem eq_signed_to_small_unsigned_thm (e : IntW 8) :
  icmp IntPred.eq (sext 32 e) (const? 32 17) ⊑ icmp IntPred.eq e (const? 8 17) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
