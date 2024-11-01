
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshlhunsignedhcmphconst_proof
theorem scalar_i8_shl_ult_const_1_thm (e : IntW 8) :
  icmp IntPredicate.ult (shl e (const? 5)) (const? 64) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 6)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i8_shl_ult_const_2_thm (e : IntW 8) :
  icmp IntPredicate.ult (shl e (const? 6)) (const? 64) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 3)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i8_shl_ult_const_3_thm (e : IntW 8) :
  icmp IntPredicate.ult (shl e (const? 7)) (const? 64) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i16_shl_ult_const_thm (e : IntW 16) :
  icmp IntPredicate.ult (shl e (const? 8)) (const? 1024) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 252)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_shl_ult_const_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl e (const? 11)) (const? 131072) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 2097088)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i64_shl_ult_const_thm (e : IntW 64) :
  icmp IntPredicate.ult (shl e (const? 25)) (const? 8589934592) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 549755813632)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i8_shl_uge_const_thm (e : IntW 8) :
  icmp IntPredicate.uge (shl e (const? 5)) (const? 64) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 6)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i8_shl_ule_const_thm (e : IntW 8) :
  icmp IntPredicate.ule (shl e (const? 5)) (const? 63) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 6)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i8_shl_ugt_const_thm (e : IntW 8) :
  icmp IntPredicate.ugt (shl e (const? 5)) (const? 63) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 6)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


