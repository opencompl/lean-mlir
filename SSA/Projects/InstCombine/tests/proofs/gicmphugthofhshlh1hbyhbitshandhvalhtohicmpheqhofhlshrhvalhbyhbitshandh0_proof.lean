
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphugthofhshlh1hbyhbitshandhvalhtohicmpheqhofhlshrhvalhbyhbitshandh0_proof
theorem p0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ugt (shl (const? 8 1) e_1) e ⊑ icmp IntPredicate.eq (lshr e e_1) (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem both_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ugt (shl (const? 8 1) e_1) (shl (const? 8 1) e) ⊑
    icmp IntPredicate.eq (lshr (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) e_1) (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.uge (shl (const? 8 1) e_1) e ⊑
    icmp IntPredicate.uge (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


