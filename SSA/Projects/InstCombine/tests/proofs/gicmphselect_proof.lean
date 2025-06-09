
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphselect_proof
theorem icmp_select_const_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (select (icmp IntPred.eq e_1 (const? 8 0)) (const? 8 0) e) (const? 8 0) ⊑
    select (icmp IntPred.eq e_1 (const? 8 0)) (const? 1 1) (icmp IntPred.eq e (const? 8 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_var_thm (e e_1 e_2 : IntW 8) :
  icmp IntPred.eq (select (icmp IntPred.eq e_2 (const? 8 0)) e_1 e) e_1 ⊑
    select (icmp IntPred.eq e_2 (const? 8 0)) (const? 1 1) (icmp IntPred.eq e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_var_commuted_thm (e e_1 e_2 : IntW 8) :
  icmp IntPred.eq (LLVM.udiv (const? 8 42) e_2)
      (select (icmp IntPred.eq e_1 (const? 8 0)) (LLVM.udiv (const? 8 42) e_2) e) ⊑
    select (icmp IntPred.eq e_1 (const? 8 0)) (const? 1 1)
      (icmp IntPred.eq e (LLVM.udiv (const? 8 42) e_2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_var_select_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.eq (select e_2 e_1 e) (select (icmp IntPred.eq e_1 (const? 8 0)) (select e_2 e_1 e) e) ⊑
    select (select (icmp IntPred.eq e_1 (const? 8 0)) (const? 1 1) (LLVM.xor e_2 (const? 1 1))) (const? 1 1)
      (icmp IntPred.eq e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_var_both_fold_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (select (icmp IntPred.eq e_1 (const? 8 0)) (LLVM.or e (const? 8 1)) (const? 8 2))
      (LLVM.or e (const? 8 1)) ⊑
    icmp IntPred.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_var_pred_ne_thm (e e_1 e_2 : IntW 8) :
  icmp IntPred.ne (select (icmp IntPred.eq e_2 (const? 8 0)) e_1 e) e_1 ⊑
    select (icmp IntPred.ne e_2 (const? 8 0)) (icmp IntPred.ne e e_1) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_var_pred_ult_thm (e e_1 e_2 : IntW 8) :
  icmp IntPred.ult (select (icmp IntPred.eq e_2 (const? 8 0)) e_1 e)
      (add e_1 (const? 8 2) { «nsw» := false, «nuw» := true }) ⊑
    select (icmp IntPred.eq e_2 (const? 8 0)) (const? 1 1)
      (icmp IntPred.ult e (add e_1 (const? 8 2) { «nsw» := false, «nuw» := true })) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_var_pred_uge_thm (e e_1 e_2 : IntW 8) :
  icmp IntPred.uge (select (icmp IntPred.eq e_2 (const? 8 0)) e_1 e)
      (add e_1 (const? 8 2) { «nsw» := false, «nuw» := true }) ⊑
    select (icmp IntPred.ne e_2 (const? 8 0))
      (icmp IntPred.uge e (add e_1 (const? 8 2) { «nsw» := false, «nuw» := true })) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_var_pred_uge_commuted_thm (e e_1 e_2 : IntW 8) :
  icmp IntPred.uge (add e_2 (const? 8 2) { «nsw» := false, «nuw» := true })
      (select (icmp IntPred.eq e_1 (const? 8 0)) e_2 e) ⊑
    select (icmp IntPred.eq e_1 (const? 8 0)) (const? 1 1)
      (icmp IntPred.ule e (add e_2 (const? 8 2) { «nsw» := false, «nuw» := true })) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_implied_cond_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (select (icmp IntPred.eq e_1 (const? 8 0)) (const? 8 0) e) e_1 ⊑
    select (icmp IntPred.eq e_1 (const? 8 0)) (const? 1 1) (icmp IntPred.eq e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_implied_cond_ne_thm (e e_1 : IntW 8) :
  icmp IntPred.ne (select (icmp IntPred.eq e_1 (const? 8 0)) (const? 8 0) e) e_1 ⊑
    select (icmp IntPred.ne e_1 (const? 8 0)) (icmp IntPred.ne e e_1) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_implied_cond_swapped_select_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (select (icmp IntPred.eq e_1 (const? 8 0)) e (const? 8 0)) e_1 ⊑
    select (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.eq e (const? 8 0)) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_select_implied_cond_relational_thm (e e_1 : IntW 8) :
  icmp IntPred.ult (select (icmp IntPred.ugt e_1 (const? 8 10)) (const? 8 10) e) e_1 ⊑
    select (icmp IntPred.ugt e_1 (const? 8 10)) (const? 1 1) (icmp IntPred.ult e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_constants_and_icmp_eq0_thm (e e_1 : IntW 1) :
  icmp IntPred.eq (LLVM.and (select e_1 (const? 8 2) (const? 8 1)) (select e (const? 8 2) (const? 8 1)))
      (const? 8 0) ⊑
    LLVM.xor e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_constants_and_icmp_eq0_common_bit_thm (e e_1 : IntW 1) :
  icmp IntPred.eq (LLVM.and (select e_1 (const? 8 2) (const? 8 3)) (select e (const? 8 2) (const? 8 3)))
      (const? 8 0) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_constants_and_icmp_eq0_zero_tval_thm (e e_1 : IntW 1) :
  icmp IntPred.eq (LLVM.and (select e_1 (const? 8 0) (const? 8 12)) (select e (const? 8 0) (const? 8 12)))
      (const? 8 0) ⊑
    select e_1 (const? 1 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_constants_and_icmp_eq0_zero_fval_thm (e e_1 : IntW 1) :
  icmp IntPred.eq (LLVM.and (select e_1 (const? 8 12) (const? 8 0)) (select e (const? 8 12) (const? 8 0)))
      (const? 8 0) ⊑
    LLVM.xor (select e_1 e (const? 1 0)) (const? 1 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_constants_and_icmp_ne0_thm (e e_1 : IntW 1) :
  icmp IntPred.ne (LLVM.and (select e_1 (const? 8 2) (const? 8 1)) (select e (const? 8 2) (const? 8 1)))
      (const? 8 0) ⊑
    LLVM.xor (LLVM.xor e_1 e) (const? 1 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_constants_and_icmp_ne0_common_bit_thm (e e_1 : IntW 1) :
  icmp IntPred.ne (LLVM.and (select e_1 (const? 8 2) (const? 8 3)) (select e (const? 8 2) (const? 8 3)))
      (const? 8 0) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_constants_and_icmp_ne0_zero_tval_thm (e e_1 : IntW 1) :
  icmp IntPred.ne (LLVM.and (select e_1 (const? 8 0) (const? 8 12)) (select e (const? 8 0) (const? 8 12)))
      (const? 8 0) ⊑
    LLVM.xor (select e_1 (const? 1 1) e) (const? 1 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_constants_and_icmp_ne0_zero_fval_thm (e e_1 : IntW 1) :
  icmp IntPred.ne (LLVM.and (select e_1 (const? 8 12) (const? 8 0)) (select e (const? 8 12) (const? 8 0)))
      (const? 8 0) ⊑
    select e_1 e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_select_thm (e e_1 : IntW 32) (e_2 : IntW 1) :
  icmp IntPred.eq (select e_2 e_1 e) (select e_2 e e_1) ⊑ icmp IntPred.eq e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
