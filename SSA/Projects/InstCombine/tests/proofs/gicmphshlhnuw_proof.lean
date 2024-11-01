
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphshlhnuw_proof
theorem icmp_ugt_32_thm (e : IntW 64) :
  icmp IntPredicate.ugt (shl e (const? 32) { «nsw» := false, «nuw» := true }) (const? 4294967295) ⊑
    icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ule_64_thm (e : IntW 128) :
  icmp IntPredicate.ule (shl e (const? 64) { «nsw» := false, «nuw» := true }) (const? 18446744073709551615) ⊑
    icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ugt_16_thm (e : IntW 64) :
  icmp IntPredicate.ugt (shl e (const? 16) { «nsw» := false, «nuw» := true }) (const? 1048575) ⊑
    icmp IntPredicate.ugt e (const? 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ult_8_thm (e : IntW 64) :
  icmp IntPredicate.ult (shl e (const? 8) { «nsw» := false, «nuw» := true }) (const? 4095) ⊑
    icmp IntPredicate.ult e (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_icmp_shl_nuw_c1_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 2) (LLVM.and (lshr e (const? 12)) (const? 15)) { «nsw» := false, «nuw» := true })
      (const? 4) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 61440)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 16) e { «nsw» := false, «nuw» := true }) (const? 64) ⊑
    icmp IntPredicate.ult e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_non_pow2_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 48) e { «nsw» := false, «nuw» := true }) (const? 192) ⊑
    icmp IntPredicate.ult e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_div_non_pow2_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 2) e { «nsw» := false, «nuw» := true }) (const? 60) ⊑
    icmp IntPredicate.ult e (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_icmp_shl_nuw_c3_thm (e : IntW 32) :
  icmp IntPredicate.uge (shl (const? 48) e { «nsw» := false, «nuw» := true }) (const? 144) ⊑
    icmp IntPredicate.ugt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_indivisible_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 16) e { «nsw» := false, «nuw» := true }) (const? 63) ⊑
    icmp IntPredicate.ult e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_precondition1_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 0) e { «nsw» := false, «nuw» := true }) (const? 63) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_precondition2_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 127) e { «nsw» := false, «nuw» := true }) (const? 63) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_precondition3_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


