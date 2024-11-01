
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehconstanthlowhbithmaskhandhicmphsgehtohicmphsle_proof
theorem p0_thm (e : IntW 8) :
  icmp IntPredicate.sge (LLVM.and e (const? 8 3)) e ⊑ icmp IntPredicate.slt e (const? 8 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


