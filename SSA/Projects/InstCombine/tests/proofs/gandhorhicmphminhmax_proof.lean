
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gandhorhicmphminhmax_proof
theorem slt_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.eq e_1 (const? 8 127)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.eq e_1 (const? 8 127)) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.sgt e_1 e) (icmp IntPredicate.eq e (const? 8 127)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sgt e_1 e) (icmp IntPredicate.eq e (const? 8 127)) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 127)) (icmp IntPredicate.sgt e e_1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 127)) (icmp IntPredicate.sgt e e_1) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.eq e_1 (const? 8 (-1))) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.eq e_1 (const? 8 (-1))) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.ult e_1 e) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.ult e_1 e) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.eq e (const? 8 (-1))) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.eq e (const? 8 (-1))) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.ugt e e_1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.ugt e e_1) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_and_min_thm (e e_1 : IntW 9) :
  LLVM.and (icmp IntPredicate.sgt e_1 e) (icmp IntPredicate.eq e_1 (const? 9 (-256))) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_and_min_logical_thm (e e_1 : IntW 9) :
  select (icmp IntPredicate.sgt e_1 e) (icmp IntPredicate.eq e_1 (const? 9 (-256))) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.sgt e_1 e) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.sgt e_1 e) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.eq e (const? 8 (-128))) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.eq e (const? 8 (-128))) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.slt e e_1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.slt e e_1) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.eq e_1 (const? 8 0)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.eq e_1 (const? 8 0)) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 0)) (icmp IntPredicate.ugt e_1 e) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 0)) (icmp IntPredicate.ugt e_1 e) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.eq e (const? 8 0)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.eq e (const? 8 0)) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 0)) (icmp IntPredicate.ult e e_1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 0)) (icmp IntPredicate.ult e e_1) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sge e_1 e) (icmp IntPredicate.ne e_1 (const? 8 127)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sge e_1 e) (const? 1 1) (icmp IntPredicate.ne e_1 (const? 8 127)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 127)) (icmp IntPredicate.sge e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 127)) (const? 1 1) (icmp IntPredicate.sge e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sle e_1 e) (icmp IntPredicate.ne e (const? 8 127)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sle e_1 e) (const? 1 1) (icmp IntPredicate.ne e (const? 8 127)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 127)) (icmp IntPredicate.sle e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 127)) (const? 1 1) (icmp IntPredicate.sle e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.uge e_1 e) (icmp IntPredicate.ne e_1 (const? 8 (-1))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.uge e_1 e) (const? 1 1) (icmp IntPredicate.ne e_1 (const? 8 (-1))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 (-1))) (icmp IntPredicate.uge e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 (-1))) (const? 1 1) (icmp IntPredicate.uge e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ule e_1 e) (icmp IntPredicate.ne e (const? 8 (-1))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ule e_1 e) (const? 1 1) (icmp IntPredicate.ne e (const? 8 (-1))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 (-1))) (icmp IntPredicate.ule e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 (-1))) (const? 1 1) (icmp IntPredicate.ule e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sle e_1 e) (icmp IntPredicate.ne e_1 (const? 8 (-128))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sle e_1 e) (const? 1 1) (icmp IntPredicate.ne e_1 (const? 8 (-128))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 (-128))) (icmp IntPredicate.sle e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 (-128))) (const? 1 1) (icmp IntPredicate.sle e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sge e_1 e) (icmp IntPredicate.ne e (const? 8 (-128))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sge e_1 e) (const? 1 1) (icmp IntPredicate.ne e (const? 8 (-128))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 (-128))) (icmp IntPredicate.sge e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 (-128))) (const? 1 1) (icmp IntPredicate.sge e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_or_not_min_thm (e e_1 : IntW 427) :
  LLVM.or (icmp IntPredicate.ule e_1 e) (icmp IntPredicate.ne e_1 (const? 427 0)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_or_not_min_logical_thm (e e_1 : IntW 427) :
  select (icmp IntPredicate.ule e_1 e) (const? 1 1) (icmp IntPredicate.ne e_1 (const? 427 0)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 0)) (icmp IntPredicate.ule e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 0)) (const? 1 1) (icmp IntPredicate.ule e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.uge e_1 e) (icmp IntPredicate.ne e (const? 8 0)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.uge e_1 e) (const? 1 1) (icmp IntPredicate.ne e (const? 8 0)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 0)) (icmp IntPredicate.uge e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 0)) (const? 1 1) (icmp IntPredicate.uge e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.sge e_1 e) (icmp IntPredicate.eq e_1 (const? 8 127)) ⊑
    icmp IntPredicate.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sge e_1 e) (icmp IntPredicate.eq e_1 (const? 8 127)) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_and_max_logical_samesign_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sge e_1 e) (icmp IntPredicate.eq e_1 (const? 8 127)) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 127)) (icmp IntPredicate.sge e_1 e) ⊑
    icmp IntPredicate.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 127)) (icmp IntPredicate.sge e_1 e) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.sle e_1 e) (icmp IntPredicate.eq e (const? 8 127)) ⊑
    icmp IntPredicate.eq e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sle e_1 e) (icmp IntPredicate.eq e (const? 8 127)) (const? 1 0) ⊑
    icmp IntPredicate.eq e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 127)) (icmp IntPredicate.sle e e_1) ⊑
    icmp IntPredicate.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 127)) (icmp IntPredicate.sle e e_1) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.uge e_1 e) (icmp IntPredicate.eq e_1 (const? 8 (-1))) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.uge e_1 e) (icmp IntPredicate.eq e_1 (const? 8 (-1))) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.uge e_1 e) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.uge e_1 e) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ule e_1 e) (icmp IntPredicate.eq e (const? 8 (-1))) ⊑
    icmp IntPredicate.eq e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ule e_1 e) (icmp IntPredicate.eq e (const? 8 (-1))) (const? 1 0) ⊑
    icmp IntPredicate.eq e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.ule e e_1) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.ule e e_1) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.sle e_1 e) (icmp IntPredicate.eq e_1 (const? 8 (-128))) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sle e_1 e) (icmp IntPredicate.eq e_1 (const? 8 (-128))) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.sle e_1 e) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.sle e_1 e) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.sge e_1 e) (icmp IntPredicate.eq e (const? 8 (-128))) ⊑
    icmp IntPredicate.eq e (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sge e_1 e) (icmp IntPredicate.eq e (const? 8 (-128))) (const? 1 0) ⊑
    icmp IntPredicate.eq e (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.sge e e_1) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.sge e e_1) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ule e_1 e) (icmp IntPredicate.eq e_1 (const? 8 0)) ⊑
    icmp IntPredicate.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ule e_1 e) (icmp IntPredicate.eq e_1 (const? 8 0)) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 0)) (icmp IntPredicate.ule e_1 e) ⊑
    icmp IntPredicate.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 0)) (icmp IntPredicate.ule e_1 e) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.uge e_1 e) (icmp IntPredicate.eq e (const? 8 0)) ⊑
    icmp IntPredicate.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.uge e_1 e) (icmp IntPredicate.eq e (const? 8 0)) (const? 1 0) ⊑
    icmp IntPredicate.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 0)) (icmp IntPredicate.uge e e_1) ⊑
    icmp IntPredicate.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 0)) (icmp IntPredicate.uge e e_1) (const? 1 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_or_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sge e_1 e) (icmp IntPredicate.eq e_1 (const? 8 127)) ⊑ icmp IntPredicate.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_or_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sge e_1 e) (const? 1 1) (icmp IntPredicate.eq e_1 (const? 8 127)) ⊑
    icmp IntPredicate.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_or_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 8 127)) (icmp IntPredicate.sge e_1 e) ⊑ icmp IntPredicate.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_or_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sle e_1 e) (icmp IntPredicate.eq e (const? 8 127)) ⊑ icmp IntPredicate.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_or_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sle e_1 e) (const? 1 1) (icmp IntPredicate.eq e (const? 8 127)) ⊑
    icmp IntPredicate.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sge_swap_or_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 8 127)) (icmp IntPredicate.sle e e_1) ⊑ icmp IntPredicate.sle e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_or_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.uge e_1 e) (icmp IntPredicate.eq e_1 (const? 8 (-1))) ⊑
    icmp IntPredicate.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_or_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.uge e_1 e) (const? 1 1) (icmp IntPredicate.eq e_1 (const? 8 (-1))) ⊑
    icmp IntPredicate.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_or_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.uge e_1 e) ⊑
    icmp IntPredicate.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_or_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ule e_1 e) (icmp IntPredicate.eq e (const? 8 (-1))) ⊑ icmp IntPredicate.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_or_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ule e_1 e) (const? 1 1) (icmp IntPredicate.eq e (const? 8 (-1))) ⊑
    icmp IntPredicate.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_swap_or_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 8 (-1))) (icmp IntPredicate.ule e e_1) ⊑
    icmp IntPredicate.ule e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_or_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sle e_1 e) (icmp IntPredicate.eq e_1 (const? 8 (-128))) ⊑
    icmp IntPredicate.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_or_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sle e_1 e) (const? 1 1) (icmp IntPredicate.eq e_1 (const? 8 (-128))) ⊑
    icmp IntPredicate.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_or_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.sle e_1 e) ⊑
    icmp IntPredicate.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_or_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sge e_1 e) (icmp IntPredicate.eq e (const? 8 (-128))) ⊑
    icmp IntPredicate.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_or_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sge e_1 e) (const? 1 1) (icmp IntPredicate.eq e (const? 8 (-128))) ⊑
    icmp IntPredicate.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sle_swap_or_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 8 (-128))) (icmp IntPredicate.sge e e_1) ⊑
    icmp IntPredicate.sge e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_or_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ule e_1 e) (icmp IntPredicate.eq e_1 (const? 8 0)) ⊑ icmp IntPredicate.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_or_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ule e_1 e) (const? 1 1) (icmp IntPredicate.eq e_1 (const? 8 0)) ⊑
    icmp IntPredicate.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_or_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 8 0)) (icmp IntPredicate.ule e_1 e) ⊑ icmp IntPredicate.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_or_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.uge e_1 e) (icmp IntPredicate.eq e (const? 8 0)) ⊑ icmp IntPredicate.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_or_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.uge e_1 e) (const? 1 1) (icmp IntPredicate.eq e (const? 8 0)) ⊑
    icmp IntPredicate.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ule_swap_or_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 8 0)) (icmp IntPredicate.uge e e_1) ⊑ icmp IntPredicate.uge e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_and_not_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.ne e_1 (const? 8 127)) ⊑
    icmp IntPredicate.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_and_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.ne e_1 (const? 8 127)) (const? 1 0) ⊑
    icmp IntPredicate.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_and_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? 8 127)) (icmp IntPredicate.slt e_1 e) ⊑
    icmp IntPredicate.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_and_not_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.sgt e_1 e) (icmp IntPredicate.ne e (const? 8 127)) ⊑ icmp IntPredicate.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_and_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sgt e_1 e) (icmp IntPredicate.ne e (const? 8 127)) (const? 1 0) ⊑
    icmp IntPredicate.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_and_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? 8 127)) (icmp IntPredicate.sgt e e_1) ⊑
    icmp IntPredicate.sgt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_and_not_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ne e_1 (const? 8 (-1))) ⊑
    icmp IntPredicate.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_and_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ne e_1 (const? 8 (-1))) (const? 1 0) ⊑
    icmp IntPredicate.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_and_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? 8 (-1))) (icmp IntPredicate.ult e_1 e) ⊑
    icmp IntPredicate.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_and_not_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.ne e (const? 8 (-1))) ⊑ icmp IntPredicate.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_and_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.ne e (const? 8 (-1))) (const? 1 0) ⊑
    icmp IntPredicate.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_and_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? 8 (-1))) (icmp IntPredicate.ugt e e_1) ⊑
    icmp IntPredicate.ugt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_and_not_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.sgt e_1 e) (icmp IntPredicate.ne e_1 (const? 8 (-128))) ⊑
    icmp IntPredicate.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_and_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sgt e_1 e) (icmp IntPredicate.ne e_1 (const? 8 (-128))) (const? 1 0) ⊑
    icmp IntPredicate.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_and_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? 8 (-128))) (icmp IntPredicate.sgt e_1 e) ⊑
    icmp IntPredicate.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_and_not_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.ne e (const? 8 (-128))) ⊑
    icmp IntPredicate.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_and_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.ne e (const? 8 (-128))) (const? 1 0) ⊑
    icmp IntPredicate.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_and_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? 8 (-128))) (icmp IntPredicate.slt e e_1) ⊑
    icmp IntPredicate.slt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_and_not_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.ne e_1 (const? 8 0)) ⊑ icmp IntPredicate.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_and_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.ne e_1 (const? 8 0)) (const? 1 0) ⊑
    icmp IntPredicate.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_and_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? 8 0)) (icmp IntPredicate.ugt e_1 e) ⊑ icmp IntPredicate.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_and_not_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ne e (const? 8 0)) ⊑ icmp IntPredicate.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_and_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ne e (const? 8 0)) (const? 1 0) ⊑
    icmp IntPredicate.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_and_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e_1 (const? 8 0)) (icmp IntPredicate.ult e e_1) ⊑ icmp IntPredicate.ult e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.ne e_1 (const? 8 127)) ⊑
    icmp IntPredicate.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.slt e_1 e) (const? 1 1) (icmp IntPredicate.ne e_1 (const? 8 127)) ⊑
    icmp IntPredicate.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 127)) (icmp IntPredicate.slt e_1 e) ⊑
    icmp IntPredicate.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 127)) (const? 1 1) (icmp IntPredicate.slt e_1 e) ⊑
    icmp IntPredicate.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sgt e_1 e) (icmp IntPredicate.ne e (const? 8 127)) ⊑
    icmp IntPredicate.ne e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sgt e_1 e) (const? 1 1) (icmp IntPredicate.ne e (const? 8 127)) ⊑
    icmp IntPredicate.ne e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 127)) (icmp IntPredicate.sgt e e_1) ⊑
    icmp IntPredicate.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_swap_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 127)) (const? 1 1) (icmp IntPredicate.sgt e e_1) ⊑
    icmp IntPredicate.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ne e_1 (const? 8 (-1))) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ult e_1 e) (const? 1 1) (icmp IntPredicate.ne e_1 (const? 8 (-1))) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 (-1))) (icmp IntPredicate.ult e_1 e) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 (-1))) (const? 1 1) (icmp IntPredicate.ult e_1 e) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.ne e (const? 8 (-1))) ⊑
    icmp IntPredicate.ne e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ugt e_1 e) (const? 1 1) (icmp IntPredicate.ne e (const? 8 (-1))) ⊑
    icmp IntPredicate.ne e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 (-1))) (icmp IntPredicate.ugt e e_1) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_swap_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 (-1))) (const? 1 1) (icmp IntPredicate.ugt e e_1) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sgt e_1 e) (icmp IntPredicate.ne e_1 (const? 8 (-128))) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.sgt e_1 e) (const? 1 1) (icmp IntPredicate.ne e_1 (const? 8 (-128))) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 (-128))) (icmp IntPredicate.sgt e_1 e) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 (-128))) (const? 1 1) (icmp IntPredicate.sgt e_1 e) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.slt e_1 e) (icmp IntPredicate.ne e (const? 8 (-128))) ⊑
    icmp IntPredicate.ne e (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.slt e_1 e) (const? 1 1) (icmp IntPredicate.ne e (const? 8 (-128))) ⊑
    icmp IntPredicate.ne e (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 (-128))) (icmp IntPredicate.slt e e_1) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_swap_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 (-128))) (const? 1 1) (icmp IntPredicate.slt e e_1) ⊑
    icmp IntPredicate.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.ne e_1 (const? 8 0)) ⊑
    icmp IntPredicate.ne e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ugt e_1 e) (const? 1 1) (icmp IntPredicate.ne e_1 (const? 8 0)) ⊑
    icmp IntPredicate.ne e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 0)) (icmp IntPredicate.ugt e_1 e) ⊑
    icmp IntPredicate.ne e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 0)) (const? 1 1) (icmp IntPredicate.ugt e_1 e) ⊑
    icmp IntPredicate.ne e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ult e_1 e) (icmp IntPredicate.ne e (const? 8 0)) ⊑
    icmp IntPredicate.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ult e_1 e) (const? 1 1) (icmp IntPredicate.ne e (const? 8 0)) ⊑
    icmp IntPredicate.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_or_not_min_commute_thm (e e_1 : IntW 823) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 823 0)) (icmp IntPredicate.ult e e_1) ⊑
    icmp IntPredicate.ne e_1 (const? 823 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_swap_or_not_min_commute_logical_thm (e e_1 : IntW 823) :
  select (icmp IntPredicate.ne e_1 (const? 823 0)) (const? 1 1) (icmp IntPredicate.ult e e_1) ⊑
    icmp IntPredicate.ne e_1 (const? 823 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
