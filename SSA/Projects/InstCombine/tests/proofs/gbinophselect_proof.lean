
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gbinophselect_proof
theorem and_sel_op0_thm (e : IntW 1) : LLVM.and (select e (const? 32 25) (const? 32 0)) (const? 32 1) ⊑ zext 32 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_sel_op0_thm (e : IntW 32) (e_1 : IntW 1) :
  mul (select e_1 (const? 32 0) (LLVM.udiv (const? 32 42) e { «exact» := true })) e ⊑
    select e_1 (const? 32 0) (const? 32 42) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_sel_op1_thm (e : IntW 1) :
  sub (const? 32 42) (select e (const? 32 42) (const? 32 41)) { «nsw» := true, «nuw» := false } ⊑
    zext 32 (LLVM.xor e (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_sel_op1_thm (e : IntW 1) :
  ashr (const? 32 (-2)) (select e (const? 32 2) (const? 32 0)) ⊑ select e (const? 32 (-1)) (const? 32 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
