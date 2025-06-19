
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gselect_meta_proof
theorem foo_thm (e : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 2)) (add e (const? 32 20) { «nsw» := true, «nuw» := false })
      (add e (const? 32 (-20))) ⊑
    add e (select (icmp IntPred.sgt e (const? 32 2)) (const? 32 20) (const? 32 (-20))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shrink_select_thm (e : IntW 32) (e_1 : IntW 1) :
  trunc 8 (select e_1 e (const? 32 42)) ⊑ select e_1 (trunc 8 e) (const? 8 42) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo2_thm (e e_1 : IntW 32) :
  select (icmp IntPred.sgt e_1 (const? 32 2)) (add e_1 e { «nsw» := true, «nuw» := false })
      (sub e_1 e { «nsw» := true, «nuw» := false }) ⊑
    add e_1 (select (icmp IntPred.sgt e_1 (const? 32 2)) e (sub (const? 32 0) e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_cond_thm (e e_1 : IntW 32) (e_2 : IntW 1) :
  select (LLVM.xor e_2 (const? 1 1)) e_1 e ⊑ select e_2 e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_add_thm (e e_1 : IntW 64) (e_2 : IntW 1) :
  select e_2 (add e_1 e) e_1 ⊑ add e_1 (select e_2 e (const? 64 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_sub_thm (e e_1 : IntW 17) (e_2 : IntW 1) :
  select e_2 (sub e_1 e) e_1 ⊑ sub e_1 (select e_2 e (const? 17 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_ashr_thm (e e_1 : IntW 128) (e_2 : IntW 1) :
  select e_2 (ashr e_1 e) e_1 ⊑ ashr e_1 (select e_2 e (const? 128 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
