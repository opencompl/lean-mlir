
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphshl_proof
theorem shl_nuw_eq_0_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (shl e_1 e { «nsw» := false, «nuw» := true }) (const? 8 0) ⊑
    icmp IntPred.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_nsw_slt_1_thm (e e_1 : IntW 8) :
  icmp IntPred.slt (shl e_1 e { «nsw» := true, «nuw» := false }) (const? 8 1) ⊑
    icmp IntPred.slt e_1 (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_nsw_sgt_n1_thm (e e_1 : IntW 8) :
  icmp IntPred.sgt (shl e_1 e { «nsw» := true, «nuw» := false }) (const? 8 (-1)) ⊑
    icmp IntPred.sgt e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_nsw_nuw_ult_Csle0_thm (e e_1 : IntW 8) :
  icmp IntPred.ult (shl e_1 e { «nsw» := true, «nuw» := true }) (const? 8 (-19)) ⊑
    icmp IntPred.ult e_1 (const? 8 (-19)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_nsw_ule_Csle0_fail_missing_flag_thm (e e_1 : IntW 8) :
  icmp IntPred.ule (shl e_1 e { «nsw» := true, «nuw» := false }) (const? 8 (-19)) ⊑
    icmp IntPred.ult (shl e_1 e { «nsw» := true, «nuw» := false }) (const? 8 (-18)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem shl_nsw_nuw_uge_Csle0_thm (e e_1 : IntW 8) :
  icmp IntPred.uge (shl e_1 e { «nsw» := true, «nuw» := true }) (const? 8 (-120)) ⊑
    icmp IntPred.ugt e_1 (const? 8 (-121)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
