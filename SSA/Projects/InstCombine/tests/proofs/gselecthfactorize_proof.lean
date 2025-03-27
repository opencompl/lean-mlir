
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gselecthfactorize_proof
theorem logic_and_logic_or_1_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (select e_2 e (const? 1 0)) ⊑
    select e_2 (select e_1 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_and_logic_or_2_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (select e_1 e (const? 1 0)) ⊑
    select e_1 (select e_2 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_and_logic_or_3_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (select e e_1 (const? 1 0)) ⊑
    select (select e_2 (const? 1 1) e) e_1 (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_and_logic_or_4_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (select e e_2 (const? 1 0)) ⊑
    select e_2 (select e_1 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_and_logic_or_5_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (select e_2 e (const? 1 0)) ⊑
    select e_2 (select e_1 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_and_logic_or_6_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (select e e_2 (const? 1 0)) ⊑
    select e_2 (select e_1 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_and_logic_or_7_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (select e e_1 (const? 1 0)) ⊑
    select (select e_2 (const? 1 1) e) e_1 (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_and_logic_or_8_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (select e_1 e (const? 1 0)) ⊑
    select e_1 (select e_2 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_logic_and_logic_or_1_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 e_1) (const? 1 1) (select e_2 e (const? 1 0)) ⊑
    select e_2 (select e_1 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_logic_and_logic_or_2_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 e_1) (const? 1 1) (select e e_2 (const? 1 0)) ⊑
    select e_2 (select e_1 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_logic_and_logic_or_3_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 e_1) (const? 1 1) (select e_1 e (const? 1 0)) ⊑
    select e_1 (select e_2 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_logic_and_logic_or_4_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 e_1) (const? 1 1) (select e e_1 (const? 1 0)) ⊑
    select e_1 (select e_2 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_logic_and_logic_or_5_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (LLVM.and e_2 e) ⊑
    select e_2 (select e_1 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_logic_and_logic_or_6_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (LLVM.and e_1 e) ⊑ LLVM.and e_1 (select e_2 (const? 1 1) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_logic_and_logic_or_7_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (LLVM.and e e_2) ⊑
    select e_2 (select e_1 (const? 1 1) e) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_logic_and_logic_or_8_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 e_1 (const? 1 0)) (const? 1 1) (LLVM.and e e_1) ⊑ LLVM.and e_1 (select e_2 (const? 1 1) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_and_logic_or_1_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 e_1) (const? 1 1) (LLVM.and e_2 e) ⊑ LLVM.and e_2 (select e_1 (const? 1 1) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_and_logic_or_2_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 e_1) (const? 1 1) (LLVM.and e e_2) ⊑ LLVM.and e_2 (select e_1 (const? 1 1) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_or_logic_and_1_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (select e_2 (const? 1 1) e) (const? 1 0) ⊑
    select e_2 (const? 1 1) (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_or_logic_and_2_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (select e_1 (const? 1 1) e) (const? 1 0) ⊑
    select e_1 (const? 1 1) (select e_2 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_or_logic_and_3_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (select e (const? 1 1) e_1) (const? 1 0) ⊑
    select (select e_2 e (const? 1 0)) (const? 1 1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_or_logic_and_4_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (select e (const? 1 1) e_2) (const? 1 0) ⊑
    select e_2 (const? 1 1) (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_or_logic_and_5_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (select e_2 (const? 1 1) e) (const? 1 0) ⊑
    select e_2 (const? 1 1) (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_or_logic_and_6_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (select e (const? 1 1) e_2) (const? 1 0) ⊑
    select e_2 (const? 1 1) (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_or_logic_and_7_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (select e (const? 1 1) e_1) (const? 1 0) ⊑
    select (select e_2 e (const? 1 0)) (const? 1 1) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logic_or_logic_and_8_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (select e_1 (const? 1 1) e) (const? 1 0) ⊑
    select e_1 (const? 1 1) (select e_2 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_logic_or_logic_and_1_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 e_1) (select e_2 (const? 1 1) e) (const? 1 0) ⊑
    select e_2 (const? 1 1) (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_logic_or_logic_and_2_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 e_1) (select e (const? 1 1) e_2) (const? 1 0) ⊑
    select e_2 (const? 1 1) (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_logic_or_logic_and_3_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (LLVM.or e_2 e) (const? 1 0) ⊑
    select e_2 (const? 1 1) (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_logic_or_logic_and_4_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (LLVM.or e_1 e) (const? 1 0) ⊑ LLVM.or e_1 (select e_2 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_logic_or_logic_and_5_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 e_1) (select e_1 (const? 1 1) e) (const? 1 0) ⊑
    select e_1 (const? 1 1) (select e_2 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_logic_or_logic_and_6_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 e_1) (select e (const? 1 1) e_1) (const? 1 0) ⊑
    select e_1 (const? 1 1) (select e_2 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_logic_or_logic_and_7_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (LLVM.or e e_2) (const? 1 0) ⊑
    select e_2 (const? 1 1) (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_logic_or_logic_and_8_thm (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e_1) (LLVM.or e e_1) (const? 1 0) ⊑ LLVM.or e_1 (select e_2 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_or_logic_and_1_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 e_1) (LLVM.or e e_2) (const? 1 0) ⊑ LLVM.or e_2 (select e_1 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_or_logic_and_2_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 e_1) (LLVM.or e_1 e) (const? 1 0) ⊑ LLVM.or e_1 (select e_2 e (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
