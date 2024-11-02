
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gJavaCompare_proof
theorem le_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sle
      (select (icmp IntPredicate.slt e_1 e) (const? 32 (-1))
        (select (icmp IntPredicate.sgt e_1 e) (const? 32 1) (const? 32 0)))
      (const? 32 0) ⊑
    icmp IntPredicate.sle e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


