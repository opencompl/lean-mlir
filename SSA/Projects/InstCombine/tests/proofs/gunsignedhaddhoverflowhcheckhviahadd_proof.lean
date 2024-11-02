
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gunsignedhaddhoverflowhcheckhviahadd_proof
theorem t6_no_extrause_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (add e_1 e) e ⊑ icmp IntPredicate.ugt e_1 (LLVM.xor e (const? 8 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


