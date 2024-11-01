
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphshl_proof
theorem shl_nuw_eq_0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (shl e_1 e { «nsw» := false, «nuw» := true }) (const? 0) ⊑
    icmp IntPredicate.eq e_1 (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_slt_1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (shl e_1 e { «nsw» := true, «nuw» := false }) (const? 1) ⊑
    icmp IntPredicate.slt e_1 (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_sgt_n1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sgt (shl e_1 e { «nsw» := true, «nuw» := false }) (const? (-1)) ⊑
    icmp IntPredicate.sgt e_1 (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_nuw_ult_Csle0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (shl e_1 e { «nsw» := true, «nuw» := true }) (const? (-19)) ⊑
    icmp IntPredicate.ult e_1 (const? (-19)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_ule_Csle0_fail_missing_flag_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ule (shl e_1 e { «nsw» := true, «nuw» := false }) (const? (-19)) ⊑
    icmp IntPredicate.ult (shl e_1 e { «nsw» := true, «nuw» := false }) (const? (-18)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_nuw_uge_Csle0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.uge (shl e_1 e { «nsw» := true, «nuw» := true }) (const? (-120)) ⊑
    icmp IntPredicate.ugt e_1 (const? (-121)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


