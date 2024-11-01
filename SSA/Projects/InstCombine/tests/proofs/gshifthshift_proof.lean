
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthshift_proof
theorem shl_shl_thm (e✝ : IntW 32) : shl (shl e✝ (const? 6)) (const? 28) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_lshr_thm (e✝ : IntW 232) : lshr (lshr e✝ (const? 231)) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_trunc_bigger_lshr_thm (e✝ : IntW 32) :
  shl (trunc 8 (lshr e✝ (const? 5))) (const? 3) ⊑ LLVM.and (trunc 8 (lshr e✝ (const? 2))) (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_trunc_smaller_lshr_thm (e✝ : IntW 32) :
  shl (trunc 8 (lshr e✝ (const? 3))) (const? 5) ⊑ LLVM.and (shl (trunc 8 e✝) (const? 2)) (const? (-32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_trunc_bigger_ashr_thm (e✝ : IntW 32) :
  shl (trunc 24 (ashr e✝ (const? 12))) (const? 3) ⊑ LLVM.and (trunc 24 (ashr e✝ (const? 9))) (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_trunc_smaller_ashr_thm (e✝ : IntW 32) :
  shl (trunc 24 (ashr e✝ (const? 10))) (const? 13) ⊑ LLVM.and (shl (trunc 24 e✝) (const? 3)) (const? (-8192)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_trunc_bigger_shl_thm (e✝ : IntW 32) : shl (trunc 8 (shl e✝ (const? 4))) (const? 2) ⊑ shl (trunc 8 e✝) (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_trunc_smaller_shl_thm (e✝ : IntW 32) : shl (trunc 8 (shl e✝ (const? 2))) (const? 4) ⊑ shl (trunc 8 e✝) (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_shl_constants_div_thm (e✝ e✝¹ : IntW 32) :
  LLVM.udiv e✝¹ (shl (shl (const? 1) e✝) (const? 2)) ⊑ lshr e✝¹ (add e✝ (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_shl_constants_thm (e✝ : IntW 32) :
  shl (ashr (const? (-33)) e✝) (const? 3) ⊑
    shl (ashr (const? (-33)) e✝) (const? 3) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_demand1_thm (e✝ : IntW 8) :
  LLVM.or (lshr (shl (const? 40) e✝) (const? 3)) (const? (-32)) ⊑ LLVM.or (shl (const? 5) e✝) (const? (-32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_lshr_demand6_thm (e✝ : IntW 16) :
  LLVM.and (lshr (shl (const? (-32624)) e✝) (const? 4)) (const? 4094) ⊑
    LLVM.and (shl (const? 2057) e✝) (const? 4094) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_shl_demand1_thm (e✝ : IntW 8) :
  LLVM.or (shl (lshr (const? 28) e✝) (const? 3)) (const? 7) ⊑ LLVM.or (lshr (const? (-32)) e✝) (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_shl_demand3_thm (e✝ : IntW 8) :
  LLVM.or (shl (lshr (const? 28) e✝) (const? 3)) (const? 3) ⊑
    LLVM.or (shl (lshr (const? 28) e✝) (const? 3) { «nsw» := false, «nuw» := true }) (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


