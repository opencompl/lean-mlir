
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gJavaCompare_proof
theorem le_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sle
      (select (icmp IntPredicate.slt e_1 e) (const? (-1)) (select (icmp IntPredicate.sgt e_1 e) (const? 1) (const? 0)))
      (const? 0) ⊑
    icmp IntPredicate.sle e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


