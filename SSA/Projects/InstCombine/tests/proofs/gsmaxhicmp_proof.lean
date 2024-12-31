
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsmaxhicmp_proof
theorem eq_smax1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (select (icmp IntPredicate.sgt e_1 e) e_1 e) e_1 ⊑ icmp IntPredicate.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_smax2_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (select (icmp IntPredicate.sgt e_1 e) e_1 e) e ⊑ icmp IntPredicate.sge e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_smax3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (add e_1 (const? 32 3))
      (select (icmp IntPredicate.sgt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPredicate.sge (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_smax4_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (add e_1 (const? 32 3))
      (select (icmp IntPredicate.sgt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPredicate.sge (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_smax1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sle (select (icmp IntPredicate.sgt e_1 e) e_1 e) e_1 ⊑ icmp IntPredicate.sle e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_smax2_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sle (select (icmp IntPredicate.sgt e_1 e) e_1 e) e ⊑ icmp IntPredicate.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_smax3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sge (add e_1 (const? 32 3))
      (select (icmp IntPredicate.sgt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPredicate.sle e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_smax4_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sge (add e_1 (const? 32 3))
      (select (icmp IntPredicate.sgt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPredicate.sle e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_smax1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (select (icmp IntPredicate.sgt e_1 e) e_1 e) e_1 ⊑ icmp IntPredicate.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_smax2_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (select (icmp IntPredicate.sgt e_1 e) e_1 e) e ⊑ icmp IntPredicate.slt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_smax3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (add e_1 (const? 32 3))
      (select (icmp IntPredicate.sgt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPredicate.slt (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_smax4_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (add e_1 (const? 32 3))
      (select (icmp IntPredicate.sgt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPredicate.slt (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_smax1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sgt (select (icmp IntPredicate.sgt e_1 e) e_1 e) e_1 ⊑ icmp IntPredicate.sgt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_smax2_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sgt (select (icmp IntPredicate.sgt e_1 e) e_1 e) e ⊑ icmp IntPredicate.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_smax3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.slt (add e_1 (const? 32 3))
      (select (icmp IntPredicate.sgt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPredicate.sgt e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_smax4_thm (e e_1 : IntW 32) :
  icmp IntPredicate.slt (add e_1 (const? 32 3))
      (select (icmp IntPredicate.sgt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPredicate.sgt e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


