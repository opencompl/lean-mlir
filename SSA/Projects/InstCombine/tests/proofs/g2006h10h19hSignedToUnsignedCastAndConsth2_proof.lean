
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section g2006h10h19hSignedToUnsignedCastAndConsth2_proof
theorem eq_signed_to_small_unsigned_thm (e : IntW 8) :
  icmp IntPredicate.eq (sext 32 e) (const? 32 17) ⊑ icmp IntPredicate.eq e (const? 8 17) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


