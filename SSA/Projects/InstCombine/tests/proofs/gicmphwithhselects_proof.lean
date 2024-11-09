
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gicmphwithhselects_proof
theorem both_sides_fold_slt_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPredicate.slt (select e_1 (const? 32 9) e) (select e_1 (const? 32 1) e) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem both_sides_fold_eq_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPredicate.eq (select e_1 (const? 32 9) e) (select e_1 (const? 32 1) e) ⊑ LLVM.xor e_1 (const? 1 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem one_side_fold_slt_thm (e e_1 e_2 : IntW 32) (e_3 : IntW 1) :
  icmp IntPredicate.slt (select e_3 e_2 e_1) (select e_3 e e_1) ⊑
    select e_3 (icmp IntPredicate.slt e_2 e) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem one_side_fold_sgt_thm (e e_1 e_2 : IntW 32) (e_3 : IntW 1) :
  icmp IntPredicate.sgt (select e_3 e_2 e_1) (select e_3 e_2 e) ⊑
    select (LLVM.xor e_3 (const? 1 1)) (icmp IntPredicate.sgt e_1 e) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem one_side_fold_eq_thm (e e_1 e_2 : IntW 32) (e_3 : IntW 1) :
  icmp IntPredicate.eq (select e_3 e_2 e_1) (select e_3 e e_1) ⊑
    select (LLVM.xor e_3 (const? 1 1)) (const? 1 1) (icmp IntPredicate.eq e_2 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


