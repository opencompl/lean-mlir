
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gpr17827_proof
theorem test_shift_and_cmp_changed1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (ashr (shl (LLVM.or (LLVM.and e_1 (const? 8)) (LLVM.and e (const? 6))) (const? 5)) (const? 5))
      (const? 1) ⊑
    icmp IntPredicate.slt (LLVM.and (shl e (const? 5)) (const? (-64))) (const? 32) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shift_and_cmp_changed2_thm (e : IntW 8) :
  icmp IntPredicate.ult (LLVM.and (shl e (const? 5)) (const? (-64))) (const? 32) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 6)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shift_and_cmp_changed4_thm (e : IntW 8) :
  icmp IntPredicate.slt (LLVM.and (lshr e (const? 5)) (const? (-64))) (const? 32) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


