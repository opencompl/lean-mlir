
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gtrunchdemand_proof
theorem trunc_lshr_thm (e : IntW 8) :
  LLVM.and (trunc 6 (lshr e (const? 8 2))) (const? 6 14) ⊑
    LLVM.and (lshr (trunc 6 e) (const? 6 2)) (const? 6 14) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_lshr_exact_mask_thm (e : IntW 8) :
  LLVM.and (trunc 6 (lshr e (const? 8 2))) (const? 6 15) ⊑ lshr (trunc 6 e) (const? 6 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_lshr_big_mask_thm (e : IntW 8) :
  LLVM.and (trunc 6 (lshr e (const? 8 2))) (const? 6 31) ⊑
    LLVM.and (trunc 6 (lshr e (const? 8 2)) { «nsw» := false, «nuw» := true }) (const? 6 31) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_trunc_lshr_thm (e : IntW 8) :
  LLVM.or (trunc 6 (lshr e (const? 8 1))) (const? 6 (-32)) ⊑
    LLVM.or (lshr (trunc 6 e) (const? 6 1)) (const? 6 (-32)) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_trunc_lshr_more_thm (e : IntW 8) :
  LLVM.or (trunc 6 (lshr e (const? 8 4))) (const? 6 (-4)) ⊑
    LLVM.or (lshr (trunc 6 e) (const? 6 4)) (const? 6 (-4)) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_trunc_lshr_small_mask_thm (e : IntW 8) :
  LLVM.or (trunc 6 (lshr e (const? 8 4))) (const? 6 (-8)) ⊑
    LLVM.or (trunc 6 (lshr e (const? 8 4)) { «nsw» := true, «nuw» := true }) (const? 6 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
