
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gandhcompare_proof
theorem test1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and e_1 (const? 32 65280)) (LLVM.and e (const? 32 65280)) ⊑
    icmp IntPredicate.ne (LLVM.and (LLVM.xor e_1 e) (const? 32 65280)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_eq_0_and_15_add_1_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (add e (const? 8 1)) (const? 8 15)) (const? 8 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 15)) (const? 8 15) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_ne_0_and_15_add_1_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (add e (const? 8 1)) (const? 8 15)) (const? 8 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 15)) (const? 8 15) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_eq_0_and_15_add_3_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (add e (const? 8 3)) (const? 8 15)) (const? 8 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 15)) (const? 8 13) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_ne_0_and_15_add_3_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (add e (const? 8 3)) (const? 8 15)) (const? 8 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 15)) (const? 8 13) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_eq_11_and_15_add_10_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (add e (const? 8 10)) (const? 8 15)) (const? 8 11) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 15)) (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_ne_11_and_15_add_10_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (add e (const? 8 10)) (const? 8 15)) (const? 8 11) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 15)) (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


