
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gumaxhicmp_proof
theorem eq_umax1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (select (icmp IntPredicate.ugt e_1 e) e_1 e) e_1 ⊑ icmp IntPredicate.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_umax2_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (select (icmp IntPredicate.ugt e_1 e) e_1 e) e ⊑ icmp IntPredicate.uge e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_umax3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (add e_1 (const? 32 3))
      (select (icmp IntPredicate.ugt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPredicate.uge (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_umax4_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (add e_1 (const? 32 3))
      (select (icmp IntPredicate.ugt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPredicate.uge (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_umax1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ule (select (icmp IntPredicate.ugt e_1 e) e_1 e) e_1 ⊑ icmp IntPredicate.ule e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_umax2_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ule (select (icmp IntPredicate.ugt e_1 e) e_1 e) e ⊑ icmp IntPredicate.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_umax3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.uge (add e_1 (const? 32 3))
      (select (icmp IntPredicate.ugt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPredicate.ule e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_umax4_thm (e e_1 : IntW 32) :
  icmp IntPredicate.uge (add e_1 (const? 32 3))
      (select (icmp IntPredicate.ugt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPredicate.ule e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_umax1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (select (icmp IntPredicate.ugt e_1 e) e_1 e) e_1 ⊑ icmp IntPredicate.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_umax2_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (select (icmp IntPredicate.ugt e_1 e) e_1 e) e ⊑ icmp IntPredicate.ult e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_umax3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (add e_1 (const? 32 3))
      (select (icmp IntPredicate.ugt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPredicate.ult (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_umax4_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (add e_1 (const? 32 3))
      (select (icmp IntPredicate.ugt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPredicate.ult (add e_1 (const? 32 3)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_umax1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ugt (select (icmp IntPredicate.ugt e_1 e) e_1 e) e_1 ⊑ icmp IntPredicate.ugt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_umax2_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ugt (select (icmp IntPredicate.ugt e_1 e) e_1 e) e ⊑ icmp IntPredicate.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_umax3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ult (add e_1 (const? 32 3))
      (select (icmp IntPredicate.ugt (add e_1 (const? 32 3)) e) (add e_1 (const? 32 3)) e) ⊑
    icmp IntPredicate.ugt e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_umax4_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ult (add e_1 (const? 32 3))
      (select (icmp IntPredicate.ugt e (add e_1 (const? 32 3))) e (add e_1 (const? 32 3))) ⊑
    icmp IntPredicate.ugt e (add e_1 (const? 32 3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
