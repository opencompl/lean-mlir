
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehconstanthlowhbithmaskhandhicmphslehtohicmphsle_proof
theorem c0_thm (e : IntW 8) :
  icmp IntPredicate.sle (LLVM.and e (const? 3)) e ⊑ icmp IntPredicate.sgt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


