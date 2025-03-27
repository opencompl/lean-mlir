
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsubhlshrhorhtohicmphselect_proof
theorem neg_or_lshr_i32_thm (e : IntW 32) :
  lshr (LLVM.or (sub (const? 32 0) e) e) (const? 32 31) ⊑ zext 32 (icmp IntPredicate.ne e (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_or_lshr_i32_commute_thm (e : IntW 32) :
  lshr (LLVM.or (LLVM.sdiv (const? 32 42) e) (sub (const? 32 0) (LLVM.sdiv (const? 32 42) e))) (const? 32 31) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.sdiv (const? 32 42) e) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
