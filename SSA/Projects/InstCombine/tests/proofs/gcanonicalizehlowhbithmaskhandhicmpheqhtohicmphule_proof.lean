
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehlowhbithmaskhandhicmpheqhtohicmphule_proof
theorem p0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 8 (-1)) e_1) e) e ⊑
    icmp IntPredicate.ule e (lshr (const? 8 (-1)) e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


