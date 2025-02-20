
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gpr17827_proof
theorem test_shift_and_cmp_changed1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt
      (ashr (shl (LLVM.or (LLVM.and e_1 (const? 8 8)) (LLVM.and e (const? 8 6))) (const? 8 5)) (const? 8 5))
      (const? 8 1) ⊑
    icmp IntPredicate.slt (LLVM.and (shl e (const? 8 5)) (const? 8 (-64))) (const? 8 32) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_shift_and_cmp_changed2_thm (e : IntW 8) :
  icmp IntPredicate.ult (LLVM.and (shl e (const? 8 5)) (const? 8 (-64))) (const? 8 32) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 6)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_shift_and_cmp_changed4_thm (e : IntW 8) :
  icmp IntPredicate.slt (LLVM.and (lshr e (const? 8 5)) (const? 8 (-64))) (const? 8 32) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
