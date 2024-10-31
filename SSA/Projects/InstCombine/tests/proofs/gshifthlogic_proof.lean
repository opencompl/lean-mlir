
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthlogic_proof
theorem shl_and_thm (e✝ e✝¹ : IntW 8) :
  shl (LLVM.and (shl e✝¹ (const? 3)) e✝) (const? 2) ⊑ LLVM.and (shl e✝¹ (const? 5)) (shl e✝ (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_or_thm (e✝ e✝¹ : IntW 16) :
  shl (LLVM.or (LLVM.srem e✝¹ (const? 42)) (shl e✝ (const? 5))) (const? 7) ⊑
    LLVM.or (shl e✝ (const? 12)) (shl (LLVM.srem e✝¹ (const? 42)) (const? 7) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_xor_thm (e✝ e✝¹ : IntW 32) :
  shl (LLVM.xor (shl e✝¹ (const? 5)) e✝) (const? 7) ⊑ LLVM.xor (shl e✝¹ (const? 12)) (shl e✝ (const? 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_and_thm (e✝ e✝¹ : IntW 64) :
  lshr (LLVM.and (LLVM.srem e✝¹ (const? 42)) (lshr e✝ (const? 5))) (const? 7) ⊑
    LLVM.and (lshr e✝ (const? 12)) (lshr (LLVM.srem e✝¹ (const? 42)) (const? 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_xor_thm (e✝ e✝¹ : IntW 32) :
  ashr (LLVM.xor (LLVM.srem e✝¹ (const? 42)) (ashr e✝ (const? 5))) (const? 7) ⊑
    LLVM.xor (ashr e✝ (const? 12)) (ashr (LLVM.srem e✝¹ (const? 42)) (const? 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_mul_thm (e✝ : IntW 64) :
  lshr (mul e✝ (const? 52) { «nsw» := false, «nuw» := true }) (const? 2) ⊑
    mul e✝ (const? 13) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_mul_nuw_nsw_thm (e✝ : IntW 64) :
  lshr (mul e✝ (const? 52) { «nsw» := true, «nuw» := true }) (const? 2) ⊑
    mul e✝ (const? 13) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_thm (e✝ e✝¹ : IntW 8) :
  shl (add (shl e✝¹ (const? 3)) e✝) (const? 2) ⊑ add (shl e✝¹ (const? 5)) (shl e✝ (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_sub_thm (e✝ e✝¹ : IntW 8) :
  shl (sub (shl e✝¹ (const? 3)) e✝) (const? 2) ⊑ sub (shl e✝¹ (const? 5)) (shl e✝ (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_sub_no_commute_thm (e✝ e✝¹ : IntW 8) :
  shl (sub e✝¹ (shl e✝ (const? 3))) (const? 2) ⊑ sub (shl e✝¹ (const? 2)) (shl e✝ (const? 5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


