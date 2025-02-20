
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gshifthdirectionhinhbithtest_proof
theorem t7_twoshifts2_thm (e e_1 e_2 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl e_2 e_1) (shl (const? 32 1) e)) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and (shl e_2 e_1) (shl (const? 32 1) e { «nsw» := false, «nuw» := true }))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t8_twoshifts3_thm (e e_1 e_2 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_2) (shl e_1 e)) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true }) (shl e_1 e))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t12_shift_of_const0_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true }) e) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t14_and_with_const0_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl e_1 e) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (lshr (const? 32 1) e)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t15_and_with_const1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr e_1 e) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 32 1) e { «nsw» := false, «nuw» := true })) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
