
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubhashrhandhtohicmphselect_proof
theorem sub_ashr_and_i8_thm (e e_1 : IntW 8) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 7)) e ⊑
    select (icmp IntPredicate.slt e_1 e) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_ashr_and_i16_thm (e e_1 : IntW 16) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 15)) e ⊑
    select (icmp IntPredicate.slt e_1 e) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_ashr_and_i32_thm (e e_1 : IntW 32) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 31)) e ⊑
    select (icmp IntPredicate.slt e_1 e) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_ashr_and_i64_thm (e e_1 : IntW 64) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 63)) e ⊑
    select (icmp IntPredicate.slt e_1 e) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_ashr_and_i32_nuw_nsw_thm (e e_1 : IntW 32) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := true }) (const? 31)) e ⊑
    select (icmp IntPredicate.slt e_1 e) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_ashr_and_i32_commute_thm (e e_1 : IntW 32) :
  LLVM.and e_1 (ashr (sub e e_1 { «nsw» := true, «nuw» := false }) (const? 31)) ⊑
    select (icmp IntPredicate.slt e e_1) e_1 (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


