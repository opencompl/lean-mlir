
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsminhicmp_proof
theorem eq_smin1_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (select (icmp IntPred.slt e_1 e) e_1 e) e_1 ⊑ icmp IntPred.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_smin2_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (select (icmp IntPred.slt e_1 e) e_1 e) e ⊑ icmp IntPred.sle e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_smin3_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (add e_1 (const? 32 3))
      (select (icmp IntPred.slt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.sle (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_smin4_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (add e_1 (const? 32 3))
      (select (icmp IntPred.slt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.sle (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_smin1_thm (e e_1 : IntW 32) :
  icmp IntPred.sge (select (icmp IntPred.slt e_1 e) e_1 e) e_1 ⊑ icmp IntPred.sge e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_smin2_thm (e e_1 : IntW 32) :
  icmp IntPred.sge (select (icmp IntPred.slt e_1 e) e_1 e) e ⊑ icmp IntPred.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_smin3_thm (e e_1 : IntW 32) :
  icmp IntPred.sle (add e_1 (const? 32 3))
      (select (icmp IntPred.slt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.sge e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_smin4_thm (e e_1 : IntW 32) :
  icmp IntPred.sle (add e_1 (const? 32 3))
      (select (icmp IntPred.slt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.sge e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_smin1_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (select (icmp IntPred.slt e_1 e) e_1 e) e_1 ⊑ icmp IntPred.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_smin2_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (select (icmp IntPred.slt e_1 e) e_1 e) e ⊑ icmp IntPred.sgt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_smin3_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (add e_1 (const? 32 3))
      (select (icmp IntPred.slt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.sgt (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_smin4_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (add e_1 (const? 32 3))
      (select (icmp IntPred.slt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.sgt (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_smin1_thm (e e_1 : IntW 32) :
  icmp IntPred.slt (select (icmp IntPred.slt e_1 e) e_1 e) e_1 ⊑ icmp IntPred.slt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_smin2_thm (e e_1 : IntW 32) :
  icmp IntPred.slt (select (icmp IntPred.slt e_1 e) e_1 e) e ⊑ icmp IntPred.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_smin3_thm (e e_1 : IntW 32) :
  icmp IntPred.sgt (add e_1 (const? 32 3))
      (select (icmp IntPred.slt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.slt e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_smin4_thm (e e_1 : IntW 32) :
  icmp IntPred.sgt (add e_1 (const? 32 3))
      (select (icmp IntPred.slt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.slt e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_smin1_thm (e e_1 : IntW 32) :
  icmp IntPred.sle (select (icmp IntPred.slt e_1 e) e_1 e) e_1 ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_smin2_thm (e e_1 : IntW 32) :
  icmp IntPred.sle (select (icmp IntPred.slt e_1 e) e_1 e) e ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_smin3_thm (e e_1 : IntW 32) :
  icmp IntPred.sge (add e_1 (const? 32 3))
      (select (icmp IntPred.slt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_smin4_thm (e e_1 : IntW 32) :
  icmp IntPred.sge (add e_1 (const? 32 3))
      (select (icmp IntPred.slt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_smin1_thm (e e_1 : IntW 32) :
  icmp IntPred.sgt (select (icmp IntPred.slt e_1 e) e_1 e) e_1 ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_smin2_thm (e e_1 : IntW 32) :
  icmp IntPred.sgt (select (icmp IntPred.slt e_1 e) e_1 e) e ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_smin3_thm (e e_1 : IntW 32) :
  icmp IntPred.slt (add e_1 (const? 32 3))
      (select (icmp IntPred.slt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_smin4_thm (e e_1 : IntW 32) :
  icmp IntPred.slt (add e_1 (const? 32 3))
      (select (icmp IntPred.slt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
