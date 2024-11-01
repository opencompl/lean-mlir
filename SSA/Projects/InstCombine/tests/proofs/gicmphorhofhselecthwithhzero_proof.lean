
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphorhofhselecthwithhzero_proof
theorem src_tv_eq_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.eq (LLVM.or (select e_2 (const? 0) (add e_1 (const? 1) { «nsw» := false, «nuw» := true })) e)
      (const? 0) ⊑
    LLVM.and (icmp IntPredicate.eq e (const? 0)) e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_fv_ne_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.ne (LLVM.or (select e_2 (add e_1 (const? 1) { «nsw» := false, «nuw» := true }) (const? 0)) e)
      (const? 0) ⊑
    LLVM.or (icmp IntPredicate.ne e (const? 0)) e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_tv_ne_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.ne (LLVM.or (select e_2 (const? 0) (add e_1 (const? 1) { «nsw» := false, «nuw» := true })) e)
      (const? 0) ⊑
    LLVM.or (icmp IntPredicate.ne e (const? 0)) (LLVM.xor e_2 (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src_fv_eq_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPredicate.eq (LLVM.or (select e_2 (add e_1 (const? 1) { «nsw» := false, «nuw» := true }) (const? 0)) e)
      (const? 0) ⊑
    LLVM.and (icmp IntPredicate.eq e (const? 0)) (LLVM.xor e_2 (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


