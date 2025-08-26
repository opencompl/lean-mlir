
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
  LLVM.and (icmp IntPred.slt e_1 e) (icmp IntPred.eq e_1 (const? 8 127)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.slt e_1 e) (icmp IntPred.eq e_1 (const? 8 127)) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.sgt e_1 e) (icmp IntPred.eq e (const? 8 127)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sgt e_1 e) (icmp IntPred.eq e (const? 8 127)) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 127)) (icmp IntPred.sgt e e_1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 127)) (icmp IntPred.sgt e e_1) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ult e_1 e) (icmp IntPred.eq e_1 (const? 8 (-1))) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ult e_1 e) (icmp IntPred.eq e_1 (const? 8 (-1))) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.ult e_1 e) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.ult e_1 e) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ugt e_1 e) (icmp IntPred.eq e (const? 8 (-1))) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ugt e_1 e) (icmp IntPred.eq e (const? 8 (-1))) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.ugt e e_1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.ugt e e_1) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_and_min_thm (e e_1 : IntW 9) :
  LLVM.and (icmp IntPred.sgt e_1 e) (icmp IntPred.eq e_1 (const? 9 (-256))) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_and_min_logical_thm (e e_1 : IntW 9) :
  select (icmp IntPred.sgt e_1 e) (icmp IntPred.eq e_1 (const? 9 (-256))) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 (-128))) (icmp IntPred.sgt e_1 e) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 (-128))) (icmp IntPred.sgt e_1 e) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.slt e_1 e) (icmp IntPred.eq e (const? 8 (-128))) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.slt e_1 e) (icmp IntPred.eq e (const? 8 (-128))) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 (-128))) (icmp IntPred.slt e e_1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 (-128))) (icmp IntPred.slt e e_1) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ugt e_1 e) (icmp IntPred.eq e_1 (const? 8 0)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ugt e_1 e) (icmp IntPred.eq e_1 (const? 8 0)) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.ugt e_1 e) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.ugt e_1 e) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ult e_1 e) (icmp IntPred.eq e (const? 8 0)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ult e_1 e) (icmp IntPred.eq e (const? 8 0)) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.ult e e_1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.ult e e_1) (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.sge e_1 e) (icmp IntPred.ne e_1 (const? 8 127)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sge e_1 e) (const? 1 1) (icmp IntPred.ne e_1 (const? 8 127)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 127)) (icmp IntPred.sge e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 127)) (const? 1 1) (icmp IntPred.sge e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.sle e_1 e) (icmp IntPred.ne e (const? 8 127)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sle e_1 e) (const? 1 1) (icmp IntPred.ne e (const? 8 127)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 127)) (icmp IntPred.sle e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 127)) (const? 1 1) (icmp IntPred.sle e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.uge e_1 e) (icmp IntPred.ne e_1 (const? 8 (-1))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.uge e_1 e) (const? 1 1) (icmp IntPred.ne e_1 (const? 8 (-1))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 (-1))) (icmp IntPred.uge e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 (-1))) (const? 1 1) (icmp IntPred.uge e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ule e_1 e) (icmp IntPred.ne e (const? 8 (-1))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ule e_1 e) (const? 1 1) (icmp IntPred.ne e (const? 8 (-1))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 (-1))) (icmp IntPred.ule e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 (-1))) (const? 1 1) (icmp IntPred.ule e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.sle e_1 e) (icmp IntPred.ne e_1 (const? 8 (-128))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sle e_1 e) (const? 1 1) (icmp IntPred.ne e_1 (const? 8 (-128))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 (-128))) (icmp IntPred.sle e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 (-128))) (const? 1 1) (icmp IntPred.sle e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.sge e_1 e) (icmp IntPred.ne e (const? 8 (-128))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sge e_1 e) (const? 1 1) (icmp IntPred.ne e (const? 8 (-128))) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 (-128))) (icmp IntPred.sge e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 (-128))) (const? 1 1) (icmp IntPred.sge e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_or_not_min_thm (e e_1 : IntW 427) :
  LLVM.or (icmp IntPred.ule e_1 e) (icmp IntPred.ne e_1 (const? 427 0)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_or_not_min_logical_thm (e e_1 : IntW 427) :
  select (icmp IntPred.ule e_1 e) (const? 1 1) (icmp IntPred.ne e_1 (const? 427 0)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 0)) (icmp IntPred.ule e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 0)) (const? 1 1) (icmp IntPred.ule e_1 e) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.uge e_1 e) (icmp IntPred.ne e (const? 8 0)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.uge e_1 e) (const? 1 1) (icmp IntPred.ne e (const? 8 0)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 0)) (icmp IntPred.uge e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 0)) (const? 1 1) (icmp IntPred.uge e e_1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.sge e_1 e) (icmp IntPred.eq e_1 (const? 8 127)) ⊑
    icmp IntPred.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sge e_1 e) (icmp IntPred.eq e_1 (const? 8 127)) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_and_max_logical_samesign_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sge e_1 e) (icmp IntPred.eq e_1 (const? 8 127)) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 127)) (icmp IntPred.sge e_1 e) ⊑
    icmp IntPred.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 127)) (icmp IntPred.sge e_1 e) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.sle e_1 e) (icmp IntPred.eq e (const? 8 127)) ⊑
    icmp IntPred.eq e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sle e_1 e) (icmp IntPred.eq e (const? 8 127)) (const? 1 0) ⊑
    icmp IntPred.eq e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 127)) (icmp IntPred.sle e e_1) ⊑
    icmp IntPred.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 127)) (icmp IntPred.sle e e_1) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.uge e_1 e) (icmp IntPred.eq e_1 (const? 8 (-1))) ⊑
    icmp IntPred.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.uge e_1 e) (icmp IntPred.eq e_1 (const? 8 (-1))) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.uge e_1 e) ⊑
    icmp IntPred.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.uge e_1 e) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_and_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ule e_1 e) (icmp IntPred.eq e (const? 8 (-1))) ⊑
    icmp IntPred.eq e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_and_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ule e_1 e) (icmp IntPred.eq e (const? 8 (-1))) (const? 1 0) ⊑
    icmp IntPred.eq e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_and_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.ule e e_1) ⊑
    icmp IntPred.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_and_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.ule e e_1) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.sle e_1 e) (icmp IntPred.eq e_1 (const? 8 (-128))) ⊑
    icmp IntPred.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sle e_1 e) (icmp IntPred.eq e_1 (const? 8 (-128))) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 (-128))) (icmp IntPred.sle e_1 e) ⊑
    icmp IntPred.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 (-128))) (icmp IntPred.sle e_1 e) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.sge e_1 e) (icmp IntPred.eq e (const? 8 (-128))) ⊑
    icmp IntPred.eq e (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sge e_1 e) (icmp IntPred.eq e (const? 8 (-128))) (const? 1 0) ⊑
    icmp IntPred.eq e (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 (-128))) (icmp IntPred.sge e e_1) ⊑
    icmp IntPred.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 (-128))) (icmp IntPred.sge e e_1) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ule e_1 e) (icmp IntPred.eq e_1 (const? 8 0)) ⊑
    icmp IntPred.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ule e_1 e) (icmp IntPred.eq e_1 (const? 8 0)) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.ule e_1 e) ⊑
    icmp IntPred.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.ule e_1 e) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_and_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.uge e_1 e) (icmp IntPred.eq e (const? 8 0)) ⊑
    icmp IntPred.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_and_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.uge e_1 e) (icmp IntPred.eq e (const? 8 0)) (const? 1 0) ⊑
    icmp IntPred.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_and_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.uge e e_1) ⊑
    icmp IntPred.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_and_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.uge e e_1) (const? 1 0) ⊑
    icmp IntPred.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_or_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.sge e_1 e) (icmp IntPred.eq e_1 (const? 8 127)) ⊑ icmp IntPred.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_or_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sge e_1 e) (const? 1 1) (icmp IntPred.eq e_1 (const? 8 127)) ⊑
    icmp IntPred.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_or_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 127)) (icmp IntPred.sge e_1 e) ⊑ icmp IntPred.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_or_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.sle e_1 e) (icmp IntPred.eq e (const? 8 127)) ⊑ icmp IntPred.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_or_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sle e_1 e) (const? 1 1) (icmp IntPred.eq e (const? 8 127)) ⊑
    icmp IntPred.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sge_swap_or_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 127)) (icmp IntPred.sle e e_1) ⊑ icmp IntPred.sle e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_or_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.uge e_1 e) (icmp IntPred.eq e_1 (const? 8 (-1))) ⊑
    icmp IntPred.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_or_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.uge e_1 e) (const? 1 1) (icmp IntPred.eq e_1 (const? 8 (-1))) ⊑
    icmp IntPred.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_or_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.uge e_1 e) ⊑
    icmp IntPred.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_or_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ule e_1 e) (icmp IntPred.eq e (const? 8 (-1))) ⊑ icmp IntPred.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_or_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ule e_1 e) (const? 1 1) (icmp IntPred.eq e (const? 8 (-1))) ⊑
    icmp IntPred.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem uge_swap_or_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 (-1))) (icmp IntPred.ule e e_1) ⊑
    icmp IntPred.ule e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_or_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.sle e_1 e) (icmp IntPred.eq e_1 (const? 8 (-128))) ⊑
    icmp IntPred.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_or_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sle e_1 e) (const? 1 1) (icmp IntPred.eq e_1 (const? 8 (-128))) ⊑
    icmp IntPred.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_or_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 (-128))) (icmp IntPred.sle e_1 e) ⊑
    icmp IntPred.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_or_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.sge e_1 e) (icmp IntPred.eq e (const? 8 (-128))) ⊑
    icmp IntPred.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_or_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sge e_1 e) (const? 1 1) (icmp IntPred.eq e (const? 8 (-128))) ⊑
    icmp IntPred.sge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sle_swap_or_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 (-128))) (icmp IntPred.sge e e_1) ⊑
    icmp IntPred.sge e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_or_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ule e_1 e) (icmp IntPred.eq e_1 (const? 8 0)) ⊑ icmp IntPred.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_or_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ule e_1 e) (const? 1 1) (icmp IntPred.eq e_1 (const? 8 0)) ⊑
    icmp IntPred.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_or_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.ule e_1 e) ⊑ icmp IntPred.ule e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_or_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.uge e_1 e) (icmp IntPred.eq e (const? 8 0)) ⊑ icmp IntPred.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_or_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.uge e_1 e) (const? 1 1) (icmp IntPred.eq e (const? 8 0)) ⊑
    icmp IntPred.uge e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ule_swap_or_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.eq e_1 (const? 8 0)) (icmp IntPred.uge e e_1) ⊑ icmp IntPred.uge e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_and_not_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.slt e_1 e) (icmp IntPred.ne e_1 (const? 8 127)) ⊑
    icmp IntPred.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_and_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.slt e_1 e) (icmp IntPred.ne e_1 (const? 8 127)) (const? 1 0) ⊑
    icmp IntPred.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_and_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 127)) (icmp IntPred.slt e_1 e) ⊑
    icmp IntPred.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_and_not_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.sgt e_1 e) (icmp IntPred.ne e (const? 8 127)) ⊑ icmp IntPred.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_and_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sgt e_1 e) (icmp IntPred.ne e (const? 8 127)) (const? 1 0) ⊑
    icmp IntPred.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_and_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 127)) (icmp IntPred.sgt e e_1) ⊑
    icmp IntPred.sgt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_and_not_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ult e_1 e) (icmp IntPred.ne e_1 (const? 8 (-1))) ⊑
    icmp IntPred.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_and_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ult e_1 e) (icmp IntPred.ne e_1 (const? 8 (-1))) (const? 1 0) ⊑
    icmp IntPred.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_and_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 (-1))) (icmp IntPred.ult e_1 e) ⊑
    icmp IntPred.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_and_not_max_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ugt e_1 e) (icmp IntPred.ne e (const? 8 (-1))) ⊑ icmp IntPred.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_and_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ugt e_1 e) (icmp IntPred.ne e (const? 8 (-1))) (const? 1 0) ⊑
    icmp IntPred.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_and_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 (-1))) (icmp IntPred.ugt e e_1) ⊑
    icmp IntPred.ugt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_and_not_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.sgt e_1 e) (icmp IntPred.ne e_1 (const? 8 (-128))) ⊑
    icmp IntPred.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_and_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sgt e_1 e) (icmp IntPred.ne e_1 (const? 8 (-128))) (const? 1 0) ⊑
    icmp IntPred.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_and_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 (-128))) (icmp IntPred.sgt e_1 e) ⊑
    icmp IntPred.sgt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_and_not_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.slt e_1 e) (icmp IntPred.ne e (const? 8 (-128))) ⊑
    icmp IntPred.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_and_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.slt e_1 e) (icmp IntPred.ne e (const? 8 (-128))) (const? 1 0) ⊑
    icmp IntPred.slt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_and_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 (-128))) (icmp IntPred.slt e e_1) ⊑
    icmp IntPred.slt e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_and_not_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ugt e_1 e) (icmp IntPred.ne e_1 (const? 8 0)) ⊑ icmp IntPred.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_and_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ugt e_1 e) (icmp IntPred.ne e_1 (const? 8 0)) (const? 1 0) ⊑
    icmp IntPred.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_and_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 0)) (icmp IntPred.ugt e_1 e) ⊑ icmp IntPred.ugt e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_and_not_min_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ult e_1 e) (icmp IntPred.ne e (const? 8 0)) ⊑ icmp IntPred.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_and_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ult e_1 e) (icmp IntPred.ne e (const? 8 0)) (const? 1 0) ⊑
    icmp IntPred.ult e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_and_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPred.ne e_1 (const? 8 0)) (icmp IntPred.ult e e_1) ⊑ icmp IntPred.ult e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.slt e_1 e) (icmp IntPred.ne e_1 (const? 8 127)) ⊑
    icmp IntPred.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.slt e_1 e) (const? 1 1) (icmp IntPred.ne e_1 (const? 8 127)) ⊑
    icmp IntPred.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 127)) (icmp IntPred.slt e_1 e) ⊑
    icmp IntPred.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 127)) (const? 1 1) (icmp IntPred.slt e_1 e) ⊑
    icmp IntPred.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.sgt e_1 e) (icmp IntPred.ne e (const? 8 127)) ⊑
    icmp IntPred.ne e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sgt e_1 e) (const? 1 1) (icmp IntPred.ne e (const? 8 127)) ⊑
    icmp IntPred.ne e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 127)) (icmp IntPred.sgt e e_1) ⊑
    icmp IntPred.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem slt_swap_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 127)) (const? 1 1) (icmp IntPred.sgt e e_1) ⊑
    icmp IntPred.ne e_1 (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ult e_1 e) (icmp IntPred.ne e_1 (const? 8 (-1))) ⊑
    icmp IntPred.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ult e_1 e) (const? 1 1) (icmp IntPred.ne e_1 (const? 8 (-1))) ⊑
    icmp IntPred.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 (-1))) (icmp IntPred.ult e_1 e) ⊑
    icmp IntPred.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 (-1))) (const? 1 1) (icmp IntPred.ult e_1 e) ⊑
    icmp IntPred.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_or_not_max_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ugt e_1 e) (icmp IntPred.ne e (const? 8 (-1))) ⊑
    icmp IntPred.ne e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_or_not_max_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ugt e_1 e) (const? 1 1) (icmp IntPred.ne e (const? 8 (-1))) ⊑
    icmp IntPred.ne e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_or_not_max_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 (-1))) (icmp IntPred.ugt e e_1) ⊑
    icmp IntPred.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ult_swap_or_not_max_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 (-1))) (const? 1 1) (icmp IntPred.ugt e e_1) ⊑
    icmp IntPred.ne e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.sgt e_1 e) (icmp IntPred.ne e_1 (const? 8 (-128))) ⊑
    icmp IntPred.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.sgt e_1 e) (const? 1 1) (icmp IntPred.ne e_1 (const? 8 (-128))) ⊑
    icmp IntPred.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 (-128))) (icmp IntPred.sgt e_1 e) ⊑
    icmp IntPred.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 (-128))) (const? 1 1) (icmp IntPred.sgt e_1 e) ⊑
    icmp IntPred.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.slt e_1 e) (icmp IntPred.ne e (const? 8 (-128))) ⊑
    icmp IntPred.ne e (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.slt e_1 e) (const? 1 1) (icmp IntPred.ne e (const? 8 (-128))) ⊑
    icmp IntPred.ne e (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 (-128))) (icmp IntPred.slt e e_1) ⊑
    icmp IntPred.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem sgt_swap_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 (-128))) (const? 1 1) (icmp IntPred.slt e e_1) ⊑
    icmp IntPred.ne e_1 (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ugt e_1 e) (icmp IntPred.ne e_1 (const? 8 0)) ⊑
    icmp IntPred.ne e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ugt e_1 e) (const? 1 1) (icmp IntPred.ne e_1 (const? 8 0)) ⊑
    icmp IntPred.ne e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_or_not_min_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ne e_1 (const? 8 0)) (icmp IntPred.ugt e_1 e) ⊑
    icmp IntPred.ne e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_or_not_min_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ne e_1 (const? 8 0)) (const? 1 1) (icmp IntPred.ugt e_1 e) ⊑
    icmp IntPred.ne e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_or_not_min_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPred.ult e_1 e) (icmp IntPred.ne e (const? 8 0)) ⊑
    icmp IntPred.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_or_not_min_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPred.ult e_1 e) (const? 1 1) (icmp IntPred.ne e (const? 8 0)) ⊑
    icmp IntPred.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_or_not_min_commute_thm (e e_1 : IntW 823) :
  LLVM.or (icmp IntPred.ne e_1 (const? 823 0)) (icmp IntPred.ult e e_1) ⊑
    icmp IntPred.ne e_1 (const? 823 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem ugt_swap_or_not_min_commute_logical_thm (e e_1 : IntW 823) :
  select (icmp IntPred.ne e_1 (const? 823 0)) (const? 1 1) (icmp IntPred.ult e e_1) ⊑
    icmp IntPred.ne e_1 (const? 823 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
