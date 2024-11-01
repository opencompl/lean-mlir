
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehlowhbithmaskhandhicmphnehtohicmphugt_proof
theorem p0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (lshr (const? (-1)) e_1) e) e ⊑
    icmp IntPredicate.ugt e (lshr (const? (-1)) e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


