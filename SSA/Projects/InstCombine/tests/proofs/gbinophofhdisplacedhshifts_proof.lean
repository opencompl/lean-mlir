
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gbinophofhdisplacedhshifts_proof
theorem shl_or_thm (e✝ : IntW 8) :
  LLVM.or (shl (const? 16) e✝) (shl (const? 3) (add e✝ (const? 1))) ⊑ shl (const? 22) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_or_thm (e✝ : IntW 8) :
  LLVM.or (lshr (const? 16) e✝) (lshr (const? 3) (add e✝ (const? 1))) ⊑ lshr (const? 17) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_or_thm (e✝ : IntW 8) :
  LLVM.or (ashr (const? (-64)) e✝) (ashr (const? (-128)) (add e✝ (const? 1))) ⊑ ashr (const? (-64)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_xor_thm (e✝ : IntW 8) :
  LLVM.xor (shl (const? 16) e✝) (shl (const? 3) (add e✝ (const? 1))) ⊑ shl (const? 22) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_xor_thm (e✝ : IntW 8) :
  LLVM.xor (lshr (const? 16) e✝) (lshr (const? 3) (add e✝ (const? 1))) ⊑ lshr (const? 17) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_xor_thm (e✝ : IntW 8) :
  LLVM.xor (ashr (const? (-128)) e✝) (ashr (const? (-64)) (add e✝ (const? 1))) ⊑ lshr (const? 96) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_and_thm (e✝ : IntW 8) :
  LLVM.and (shl (const? 48) e✝) (shl (const? 8) (add e✝ (const? 1))) ⊑ shl (const? 16) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_and_thm (e✝ : IntW 8) :
  LLVM.and (lshr (const? 48) e✝) (lshr (const? 64) (add e✝ (const? 1))) ⊑ lshr (const? 32) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_and_thm (e✝ : IntW 8) :
  LLVM.and (ashr (const? (-64)) e✝) (ashr (const? (-128)) (add e✝ (const? 1))) ⊑ ashr (const? (-64)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_thm (e✝ : IntW 8) :
  add (shl (const? 16) e✝) (shl (const? 7) (add e✝ (const? 1))) ⊑ shl (const? 30) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_add_fail_thm (e✝ : IntW 8) :
  add (lshr (const? 16) e✝) (lshr (const? 7) (add e✝ (const? 1))) ⊑
    add (lshr (const? 16) e✝) (lshr (const? 7) (add e✝ (const? 1))) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_or_commuted_thm (e✝ : IntW 8) :
  LLVM.or (shl (const? 3) (add e✝ (const? 1))) (shl (const? 16) e✝) ⊑ shl (const? 22) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_or_with_or_disjoint_instead_of_add_thm (e✝ : IntW 8) :
  LLVM.or (shl (const? 16) e✝) (shl (const? 3) (LLVM.or e✝ (const? 1))) ⊑ shl (const? 22) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


