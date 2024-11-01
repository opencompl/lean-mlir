
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehconstanthlowhbithmaskhandhicmpheqhtohicmphule_proof
theorem p0_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and e (const? 3)) e ⊑ icmp IntPredicate.ult e (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem pv_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? (-1)) e_1) e) e ⊑
    icmp IntPredicate.ule e (lshr (const? (-1)) e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n0_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and e (const? 4)) e ⊑ icmp IntPredicate.eq (LLVM.and e (const? (-5))) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


