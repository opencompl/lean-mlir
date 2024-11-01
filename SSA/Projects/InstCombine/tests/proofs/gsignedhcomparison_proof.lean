
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsignedhcomparison_proof
theorem scalar_zext_slt_thm (e : IntW 16) :
  icmp IntPredicate.slt (zext 32 e) (const? 32 500) ⊑ icmp IntPredicate.ult e (const? 16 500) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


