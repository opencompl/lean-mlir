
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gumaxhicmp_proof
theorem eq_umax1_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (select (icmp IntPred.ugt e_1 e) e_1 e) e_1 ⊑ icmp IntPred.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_umax2_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (select (icmp IntPred.ugt e_1 e) e_1 e) e ⊑ icmp IntPred.uge e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_umax3_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (add e_1 (const? 32 3))
      (select (icmp IntPred.ugt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.uge (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_umax4_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (add e_1 (const? 32 3))
      (select (icmp IntPred.ugt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.uge (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_umax1_thm (e e_1 : IntW 32) :
  icmp IntPred.ule (select (icmp IntPred.ugt e_1 e) e_1 e) e_1 ⊑ icmp IntPred.ule e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_umax2_thm (e e_1 : IntW 32) :
  icmp IntPred.ule (select (icmp IntPred.ugt e_1 e) e_1 e) e ⊑ icmp IntPred.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_umax3_thm (e e_1 : IntW 32) :
  icmp IntPred.uge (add e_1 (const? 32 3))
      (select (icmp IntPred.ugt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.ule e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_umax4_thm (e e_1 : IntW 32) :
  icmp IntPred.uge (add e_1 (const? 32 3))
      (select (icmp IntPred.ugt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.ule e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_umax1_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (select (icmp IntPred.ugt e_1 e) e_1 e) e_1 ⊑ icmp IntPred.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_umax2_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (select (icmp IntPred.ugt e_1 e) e_1 e) e ⊑ icmp IntPred.ult e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_umax3_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (add e_1 (const? 32 3))
      (select (icmp IntPred.ugt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.ult (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_umax4_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (add e_1 (const? 32 3))
      (select (icmp IntPred.ugt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.ult (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_umax1_thm (e e_1 : IntW 32) :
  icmp IntPred.ugt (select (icmp IntPred.ugt e_1 e) e_1 e) e_1 ⊑ icmp IntPred.ugt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_umax2_thm (e e_1 : IntW 32) :
  icmp IntPred.ugt (select (icmp IntPred.ugt e_1 e) e_1 e) e ⊑ icmp IntPred.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_umax3_thm (e e_1 : IntW 32) :
  icmp IntPred.ult (add e_1 (const? 32 3))
      (select (icmp IntPred.ugt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.ugt e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_umax4_thm (e e_1 : IntW 32) :
  icmp IntPred.ult (add e_1 (const? 32 3))
      (select (icmp IntPred.ugt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.ugt e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
