
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthicmphandhzerohshl_proof
theorem test_eq_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 1073741823)) (const? 32 0)) (const? 32 0) (shl e (const? 32 2)) ⊑
    shl e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_ne_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 1073741823)) (const? 32 0)) (shl e (const? 32 2)) (const? 32 0) ⊑
    shl e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_nuw_dropped_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 1073741823)) (const? 32 0)) (const? 32 0)
      (shl e (const? 32 2) { «nsw» := false, «nuw» := true }) ⊑
    shl e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_nsw_dropped_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 1073741823)) (const? 32 0)) (const? 32 0)
      (shl e (const? 32 2) { «nsw» := true, «nuw» := false }) ⊑
    shl e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_test_icmp_non_equality_thm (e : IntW 32) :
  select (icmp IntPredicate.slt (LLVM.and e (const? 32 1073741823)) (const? 32 0)) (const? 32 0) (shl e (const? 32 2)) ⊑
    shl e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


