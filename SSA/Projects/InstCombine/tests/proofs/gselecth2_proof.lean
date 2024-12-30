
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gselecth2_proof
theorem ashr_exact_poison_constant_fold_thm (e : IntW 8) (e_1 : IntW 1) :
  ashr (select e_1 e (const? 8 42)) (const? 8 3) { «exact» := true } ⊑
    select e_1 (ashr e (const? 8 3)) (const? 8 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_exact_thm (e : IntW 8) (e_1 : IntW 1) :
  ashr (select e_1 e (const? 8 16)) (const? 8 3) { «exact» := true } ⊑
    select e_1 (ashr e (const? 8 3) { «exact» := true }) (const? 8 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_nsw_nuw_poison_constant_fold_thm (e : IntW 8) (e_1 : IntW 1) :
  shl (const? 8 16) (select e_1 (const? 8 3) e) { «nsw» := true, «nuw» := true } ⊑
    select e_1 (const? 8 (-128)) (shl (const? 8 16) e { «nsw» := true, «nuw» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_nsw_nuw_thm (e : IntW 8) (e_1 : IntW 1) :
  shl (const? 8 7) (select e_1 (const? 8 3) e) { «nsw» := true, «nuw» := true } ⊑
    select e_1 (const? 8 56) (shl (const? 8 7) e { «nsw» := true, «nuw» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_nsw_poison_constant_fold_thm (e : IntW 8) (e_1 : IntW 1) :
  add (select e_1 e (const? 8 65)) (const? 8 64) { «nsw» := true, «nuw» := false } ⊑
    select e_1 (add e (const? 8 64) { «nsw» := true, «nuw» := false }) (const? 8 (-127)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_nsw_thm (e : IntW 8) (e_1 : IntW 1) :
  add (select e_1 e (const? 8 7)) (const? 8 64) { «nsw» := true, «nuw» := false } ⊑
    select e_1 (add e (const? 8 64) { «nsw» := true, «nuw» := false }) (const? 8 71) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


