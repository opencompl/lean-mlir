
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphulthofhnothofhshlhalloneshbyhbitshandhvalhtohicmphnehofhlshrhvalhbyhbitshandh0_proof
theorem p0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (LLVM.xor (shl (const? (-1)) e_1) (const? (-1))) e ⊑
    icmp IntPredicate.ne (lshr e e_1) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem both_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (LLVM.xor (shl (const? (-1)) e_1) (const? (-1)))
      (LLVM.xor (shl (const? (-1)) e) (const? (-1))) ⊑
    icmp IntPredicate.ugt (shl (const? (-1)) e_1 { «nsw» := true, «nuw» := false })
      (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (LLVM.xor (shl (const? 1) e_1) (const? (-1))) e ⊑
    icmp IntPredicate.ugt e (LLVM.xor (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (LLVM.xor (shl (const? (-1)) e_1) (const? 1)) e ⊑
    icmp IntPredicate.ult (LLVM.xor (shl (const? (-1)) e_1 { «nsw» := true, «nuw» := false }) (const? 1)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n3_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ule (LLVM.xor (shl (const? (-1)) e_1) (const? (-1))) e ⊑
    icmp IntPredicate.uge e (LLVM.xor (shl (const? (-1)) e_1 { «nsw» := true, «nuw» := false }) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


