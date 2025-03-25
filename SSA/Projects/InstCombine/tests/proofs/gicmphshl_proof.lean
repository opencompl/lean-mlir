
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
  icmp IntPredicate.eq (shl e_1 e { «nsw» := false, «nuw» := true }) (const? 8 0) ⊑
    icmp IntPredicate.eq e_1 (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_nsw_slt_1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (shl e_1 e { «nsw» := true, «nuw» := false }) (const? 8 1) ⊑
    icmp IntPredicate.slt e_1 (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_nsw_sgt_n1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sgt (shl e_1 e { «nsw» := true, «nuw» := false }) (const? 8 (-1)) ⊑
    icmp IntPredicate.sgt e_1 (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_nsw_nuw_ult_Csle0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (shl e_1 e { «nsw» := true, «nuw» := true }) (const? 8 (-19)) ⊑
    icmp IntPredicate.ult e_1 (const? 8 (-19)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_nsw_ule_Csle0_fail_missing_flag_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ule (shl e_1 e { «nsw» := true, «nuw» := false }) (const? 8 (-19)) ⊑
    icmp IntPredicate.ult (shl e_1 e { «nsw» := true, «nuw» := false }) (const? 8 (-18)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_nsw_nuw_uge_Csle0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.uge (shl e_1 e { «nsw» := true, «nuw» := true }) (const? 8 (-120)) ⊑
    icmp IntPredicate.ugt e_1 (const? 8 (-121)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
