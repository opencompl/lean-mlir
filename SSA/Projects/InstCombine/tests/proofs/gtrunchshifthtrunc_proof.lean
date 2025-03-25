
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gtrunchshifthtrunc_proof
theorem trunc_lshr_trunc_thm (e : IntW 64) : trunc 8 (lshr (trunc 32 e) (const? 32 8)) ⊑ trunc 8 (lshr e (const? 64 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_lshr_trunc_outofrange_thm (e : IntW 64) :
  trunc 8 (lshr (trunc 32 e) (const? 32 25)) ⊑
    trunc 8 (lshr (trunc 32 e) (const? 32 25)) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_ashr_trunc_thm (e : IntW 64) : trunc 8 (ashr (trunc 32 e) (const? 32 8)) ⊑ trunc 8 (lshr e (const? 64 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_ashr_trunc_exact_thm (e : IntW 64) :
  trunc 8 (ashr (trunc 32 e) (const? 32 8) { «exact» := true }) ⊑
    trunc 8 (lshr e (const? 64 8) { «exact» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_ashr_trunc_outofrange_thm (e : IntW 64) :
  trunc 8 (ashr (trunc 32 e) (const? 32 25)) ⊑
    trunc 8 (ashr (trunc 32 e) (const? 32 25)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
