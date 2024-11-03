
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gicmphselecthimplieshcommonhop_proof
theorem sgt_3_impliesF_eq_2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (select (icmp IntPredicate.sgt e_1 (const? 8 3)) (const? 8 2) e) e_1 ⊑
    select (icmp IntPredicate.slt e_1 (const? 8 4)) (icmp IntPredicate.eq e e_1) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_3_impliesT_sgt_2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sgt (select (icmp IntPredicate.sgt e_1 (const? 8 3)) (const? 8 2) e) e_1 ⊑
    select (icmp IntPredicate.slt e_1 (const? 8 4)) (icmp IntPredicate.sgt e e_1) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_x_impliesF_eq_smin_todo_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.eq (select (icmp IntPredicate.sgt e_2 e_1) (const? 8 (-128)) e) e_2 ⊑
    select (icmp IntPredicate.sle e_2 e_1) (icmp IntPredicate.eq e e_2) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_x_impliesT_ne_smin_todo_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.ne e_2 (select (icmp IntPredicate.slt e_2 e_1) (const? 8 127) e) ⊑
    select (icmp IntPredicate.slt e_2 e_1) (const? 1 1) (icmp IntPredicate.ne e e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_x_impliesT_eq_umax_todo_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.ne (select (icmp IntPredicate.ugt e_2 e_1) (const? 8 (-1)) e) e_1 ⊑
    select (icmp IntPredicate.ugt e_2 e_1) (const? 1 1) (icmp IntPredicate.ne e e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_1_impliesF_eq_1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq e_1 (select (icmp IntPredicate.ult e_1 (const? 8 1)) (const? 8 1) e) ⊑
    select (icmp IntPredicate.ne e_1 (const? 8 0)) (icmp IntPredicate.eq e e_1) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


