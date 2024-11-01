
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gomithuremhofhpowerhofhtwohorhzerohwhenhcomparinghwithhzero_proof
theorem p0_scalar_urem_by_const_thm (e : IntW 32) :
  icmp IntPredicate.eq (urem (LLVM.and e (const? 128)) (const? 6)) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 128)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p1_scalar_urem_by_nonconst_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (urem (LLVM.and e_1 (const? 128)) (LLVM.or e (const? 6))) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (const? 128)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p2_scalar_shifted_urem_by_const_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (urem (shl (LLVM.and e_1 (const? 1)) e) (const? 3)) (const? 0) ⊑
    icmp IntPredicate.eq (urem (shl (LLVM.and e_1 (const? 1)) e { «nsw» := false, «nuw» := true }) (const? 3))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


