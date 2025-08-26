
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section guminhicmp_proof
theorem eq_umin1_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (select (icmp IntPred.ult e_1 e) e_1 e) e_1 ⊑ icmp IntPred.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem eq_umin2_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (select (icmp IntPred.ult e_1 e) e_1 e) e ⊑ icmp IntPred.ule e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem eq_umin3_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (add e_1 (const? 32 3))
      (select (icmp IntPred.ult (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.ule (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem eq_umin4_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (add e_1 (const? 32 3))
      (select (icmp IntPred.ult e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.ule (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_umin1_thm (e e_1 : IntW 32) :
  icmp IntPred.uge (select (icmp IntPred.ult e_1 e) e_1 e) e_1 ⊑ icmp IntPred.uge e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_umin2_thm (e e_1 : IntW 32) :
  icmp IntPred.uge (select (icmp IntPred.ult e_1 e) e_1 e) e ⊑ icmp IntPred.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_umin3_thm (e e_1 : IntW 32) :
  icmp IntPred.ule (add e_1 (const? 32 3))
      (select (icmp IntPred.ult (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.uge e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_umin4_thm (e e_1 : IntW 32) :
  icmp IntPred.ule (add e_1 (const? 32 3))
      (select (icmp IntPred.ult e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.uge e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ne_umin1_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (select (icmp IntPred.ult e_1 e) e_1 e) e_1 ⊑ icmp IntPred.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ne_umin2_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (select (icmp IntPred.ult e_1 e) e_1 e) e ⊑ icmp IntPred.ugt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ne_umin3_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (add e_1 (const? 32 3))
      (select (icmp IntPred.ult (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.ugt (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ne_umin4_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (add e_1 (const? 32 3))
      (select (icmp IntPred.ult e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.ugt (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_umin1_thm (e e_1 : IntW 32) :
  icmp IntPred.ult (select (icmp IntPred.ult e_1 e) e_1 e) e_1 ⊑ icmp IntPred.ult e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_umin2_thm (e e_1 : IntW 32) :
  icmp IntPred.ult (select (icmp IntPred.ult e_1 e) e_1 e) e ⊑ icmp IntPred.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_umin3_thm (e e_1 : IntW 32) :
  icmp IntPred.ugt (add e_1 (const? 32 3))
      (select (icmp IntPred.ult (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPred.ult e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_umin4_thm (e e_1 : IntW 32) :
  icmp IntPred.ugt (add e_1 (const? 32 3))
      (select (icmp IntPred.ult e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPred.ult e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
