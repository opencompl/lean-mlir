
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gknownhsignbithshift_proof
theorem test_shift_nonnegative_thm (e : IntW 32) :
  icmp IntPredicate.sge (shl (lshr e (const? 32 2)) (const? 32 3) { «nsw» := true, «nuw» := false }) (const? 32 0) ⊑
    const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shift_negative_thm (e e_1 : IntW 32) :
  icmp IntPredicate.slt
      (shl (LLVM.or e_1 (const? 32 (-2147483648))) (LLVM.and e (const? 32 7)) { «nsw» := true, «nuw» := false })
      (const? 32 0) ⊑
    const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


