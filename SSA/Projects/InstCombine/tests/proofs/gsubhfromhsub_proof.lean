
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsubhfromhsub_proof
theorem t0_thm (e e_1 e_2 : IntW 8) : sub (sub e_2 e_1) e ⊑ sub e_2 (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_flags_thm (e e_1 e_2 : IntW 8) :
  sub (sub e_2 e_1 { «nsw» := true, «nuw» := true }) e { «nsw» := true, «nuw» := true } ⊑
    sub e_2 (add e_1 e { «nsw» := true, «nuw» := true }) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_flags_nuw_only_thm (e e_1 e_2 : IntW 8) :
  sub (sub e_2 e_1 { «nsw» := false, «nuw» := true }) e { «nsw» := false, «nuw» := true } ⊑
    sub e_2 (add e_1 e { «nsw» := false, «nuw» := true }) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_flags_sub_nsw_sub_thm (e e_1 e_2 : IntW 8) :
  sub (sub e_2 e_1 { «nsw» := true, «nuw» := false }) e ⊑ sub e_2 (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_flags_nuw_first_thm (e e_1 e_2 : IntW 8) :
  sub (sub e_2 e_1 { «nsw» := false, «nuw» := true }) e ⊑ sub e_2 (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_flags_nuw_second_thm (e e_1 e_2 : IntW 8) :
  sub (sub e_2 e_1) e { «nsw» := false, «nuw» := true } ⊑ sub e_2 (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_flags_nuw_nsw_first_thm (e e_1 e_2 : IntW 8) :
  sub (sub e_2 e_1 { «nsw» := true, «nuw» := true }) e ⊑ sub e_2 (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_flags_nuw_nsw_second_thm (e e_1 e_2 : IntW 8) :
  sub (sub e_2 e_1) e { «nsw» := true, «nuw» := true } ⊑ sub e_2 (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t3_c0_thm (e e_1 : IntW 8) : sub (sub (const? 8 42) e_1) e ⊑ sub (const? 8 42) (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t4_c1_thm (e e_1 : IntW 8) : sub (sub e_1 (const? 8 42)) e ⊑ sub (add e_1 (const? 8 (-42))) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t5_c2_thm (e e_1 : IntW 8) : sub (sub e_1 e) (const? 8 42) ⊑ add (sub e_1 e) (const? 8 (-42)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t9_c0_c2_thm (e : IntW 8) : sub (sub (const? 8 42) e) (const? 8 24) ⊑ sub (const? 8 18) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t10_c1_c2_thm (e : IntW 8) : sub (sub e (const? 8 42)) (const? 8 24) ⊑ add e (const? 8 (-66)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


