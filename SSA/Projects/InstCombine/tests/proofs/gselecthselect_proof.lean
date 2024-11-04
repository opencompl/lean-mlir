
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gselecthselect_proof
theorem strong_order_cmp_eq_slt_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.slt e_1 e) (const? 8 (-1)) (select (icmp IntPredicate.eq e_1 e) (const? 8 0) (const? 8 1)) ⊑
    select (icmp IntPredicate.slt e_1 e) (const? 8 (-1)) (zext 8 (icmp IntPredicate.ne e_1 e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem strong_order_cmp_eq_sgt_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt e_1 e) (const? 8 1) (select (icmp IntPredicate.eq e_1 e) (const? 8 0) (const? 8 (-1))) ⊑
    select (icmp IntPredicate.sgt e_1 e) (const? 8 1) (sext 8 (icmp IntPredicate.ne e_1 e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem strong_order_cmp_eq_ult_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult e_1 e) (const? 8 (-1)) (select (icmp IntPredicate.eq e_1 e) (const? 8 0) (const? 8 1)) ⊑
    select (icmp IntPredicate.ult e_1 e) (const? 8 (-1)) (zext 8 (icmp IntPredicate.ne e_1 e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem strong_order_cmp_eq_ugt_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ugt e_1 e) (const? 8 1) (select (icmp IntPredicate.eq e_1 e) (const? 8 0) (const? 8 (-1))) ⊑
    select (icmp IntPredicate.ugt e_1 e) (const? 8 1) (sext 8 (icmp IntPredicate.ne e_1 e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


