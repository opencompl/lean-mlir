
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2005h03h04hShiftOverflow_proof
theorem test_thm (e : IntW 64) :
  icmp IntPredicate.ugt (lshr e (const? 64 1)) (const? 64 0) ⊑ icmp IntPredicate.ugt e (const? 64 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


