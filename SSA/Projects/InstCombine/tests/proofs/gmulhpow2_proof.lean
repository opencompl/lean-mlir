
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gmulhpow2_proof
theorem mul_selectp2_x_thm (e : IntW 8) (e_1 : IntW 1) :
  mul (select e_1 (const? 8 2) (const? 8 4)) e ⊑ shl e (select e_1 (const? 8 1) (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_selectp2_x_propegate_nuw_thm (e : IntW 8) (e_1 : IntW 1) :
  mul (select e_1 (const? 8 2) (const? 8 4)) e { «nsw» := true, «nuw» := true } ⊑
    shl e (select e_1 (const? 8 1) (const? 8 2)) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_selectp2_x_non_const_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  mul (select e_2 (const? 8 2) (shl (const? 8 1) e_1)) e ⊑ shl e (select e_2 (const? 8 1) e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_x_selectp2_thm (e : IntW 1) (e_1 : IntW 8) :
  mul (mul e_1 e_1) (select e (const? 8 8) (const? 8 1)) ⊑
    shl (mul e_1 e_1) (select e (const? 8 3) (const? 8 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_add_log_may_cause_poison_pr62175_with_nuw_thm (e e_1 : IntW 8) :
  mul e_1 (shl (const? 8 4) e { «nsw» := false, «nuw» := true }) ⊑ shl e_1 (add e (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_add_log_may_cause_poison_pr62175_with_nsw_thm (e e_1 : IntW 8) :
  mul e_1 (shl (const? 8 4) e { «nsw» := true, «nuw» := false }) ⊑ shl e_1 (add e (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


