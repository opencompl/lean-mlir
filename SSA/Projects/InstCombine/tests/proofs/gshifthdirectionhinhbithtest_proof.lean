
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthdirectionhinhbithtest_proof
theorem t7_twoshifts2_thm (e e_1 e_2 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl e_2 e_1) (shl (const? 1) e)) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and (shl e_2 e_1) (shl (const? 1) e { «nsw» := false, «nuw» := true }))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t8_twoshifts3_thm (e e_1 e_2 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl (const? 1) e_2) (shl e_1 e)) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and (shl (const? 1) e_2 { «nsw» := false, «nuw» := true }) (shl e_1 e))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t12_shift_of_const0_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl (const? 1) e_1) e) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t14_and_with_const0_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl e_1 e) (const? 1)) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (lshr (const? 1) e)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t15_and_with_const1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr e_1 e) (const? 1)) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


