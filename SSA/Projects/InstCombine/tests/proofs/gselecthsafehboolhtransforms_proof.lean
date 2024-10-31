
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthsafehboolhtransforms_proof
theorem land_land_left1_thm (e✝ e✝¹ : IntW 1) :
  select (select e✝¹ e✝ (const? 0)) e✝¹ (const? 0) ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_land_left2_thm (e✝ e✝¹ : IntW 1) :
  select (select e✝¹ e✝ (const? 0)) e✝ (const? 0) ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_band_left1_thm (e✝ e✝¹ : IntW 1) : LLVM.and (select e✝¹ e✝ (const? 0)) e✝¹ ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_band_left2_thm (e✝ e✝¹ : IntW 1) : LLVM.and (select e✝¹ e✝ (const? 0)) e✝ ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_lor_left1_thm (e✝ e✝¹ : IntW 1) : select (select e✝¹ e✝ (const? 0)) (const? 1) e✝¹ ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_lor_left2_thm (e✝ e✝¹ : IntW 1) : select (select e✝¹ e✝ (const? 0)) (const? 1) e✝ ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_bor_left1_thm (e✝ e✝¹ : IntW 1) : LLVM.or (select e✝¹ e✝ (const? 0)) e✝¹ ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_bor_left2_thm (e✝ e✝¹ : IntW 1) : LLVM.or (select e✝¹ e✝ (const? 0)) e✝ ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem band_land_left1_thm (e✝ e✝¹ : IntW 1) : select (LLVM.and e✝¹ e✝) e✝¹ (const? 0) ⊑ LLVM.and e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem band_land_left2_thm (e✝ e✝¹ : IntW 1) : select (LLVM.and e✝¹ e✝) e✝ (const? 0) ⊑ LLVM.and e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem band_lor_left1_thm (e✝ e✝¹ : IntW 1) : select (LLVM.and e✝¹ e✝) (const? 1) e✝¹ ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem band_lor_left2_thm (e✝ e✝¹ : IntW 1) : select (LLVM.and e✝¹ e✝) (const? 1) e✝ ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_land_left1_thm (e✝ e✝¹ : IntW 1) : select (select e✝¹ (const? 1) e✝) e✝¹ (const? 0) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_land_left2_thm (e✝ e✝¹ : IntW 1) : select (select e✝¹ (const? 1) e✝) e✝ (const? 0) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_band_left1_thm (e✝ e✝¹ : IntW 1) : LLVM.and (select e✝¹ (const? 1) e✝) e✝¹ ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_band_left2_thm (e✝ e✝¹ : IntW 1) : LLVM.and (select e✝¹ (const? 1) e✝) e✝ ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_lor_left1_thm (e✝ e✝¹ : IntW 1) :
  select (select e✝¹ (const? 1) e✝) (const? 1) e✝¹ ⊑ select e✝¹ (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_lor_left2_thm (e✝ e✝¹ : IntW 1) :
  select (select e✝¹ (const? 1) e✝) (const? 1) e✝ ⊑ select e✝¹ (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_bor_left1_thm (e✝ e✝¹ : IntW 1) : LLVM.or (select e✝¹ (const? 1) e✝) e✝¹ ⊑ select e✝¹ (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_bor_left2_thm (e✝ e✝¹ : IntW 1) : LLVM.or (select e✝¹ (const? 1) e✝) e✝ ⊑ select e✝¹ (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bor_land_left1_thm (e✝ e✝¹ : IntW 1) : select (LLVM.or e✝¹ e✝) e✝¹ (const? 0) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bor_land_left2_thm (e✝ e✝¹ : IntW 1) : select (LLVM.or e✝¹ e✝) e✝ (const? 0) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bor_lor_left1_thm (e✝ e✝¹ : IntW 1) : select (LLVM.or e✝¹ e✝) (const? 1) e✝¹ ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bor_lor_left2_thm (e✝ e✝¹ : IntW 1) : select (LLVM.or e✝¹ e✝) (const? 1) e✝ ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_land_right1_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (select e✝¹ e✝ (const? 0)) (const? 0) ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_land_right2_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (select e✝ e✝¹ (const? 0)) (const? 0) ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_band_right1_thm (e✝ e✝¹ : IntW 1) : LLVM.and e✝¹ (select e✝¹ e✝ (const? 0)) ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_band_right2_thm (e✝ e✝¹ : IntW 1) : LLVM.and e✝¹ (select e✝ e✝¹ (const? 0)) ⊑ select e✝ e✝¹ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_lor_right1_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (const? 1) (select e✝¹ e✝ (const? 0)) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_lor_right2_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (const? 1) (select e✝ e✝¹ (const? 0)) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_bor_right1_thm (e✝ e✝¹ : IntW 1) : LLVM.or e✝¹ (select e✝¹ e✝ (const? 0)) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem land_bor_right2_thm (e✝ e✝¹ : IntW 1) : LLVM.or e✝¹ (select e✝ e✝¹ (const? 0)) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem band_land_right1_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (LLVM.and e✝¹ e✝) (const? 0) ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem band_land_right2_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (LLVM.and e✝ e✝¹) (const? 0) ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem band_lor_right1_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (const? 1) (LLVM.and e✝¹ e✝) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem band_lor_right2_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (const? 1) (LLVM.and e✝ e✝¹) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_land_right1_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (select e✝¹ (const? 1) e✝) (const? 0) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_land_right2_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (select e✝ (const? 1) e✝¹) (const? 0) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_band_right1_thm (e✝ e✝¹ : IntW 1) : LLVM.and e✝¹ (select e✝¹ (const? 1) e✝) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_band_right2_thm (e✝ e✝¹ : IntW 1) : LLVM.and e✝¹ (select e✝ (const? 1) e✝¹) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_lor_right1_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (const? 1) (select e✝¹ (const? 1) e✝) ⊑ select e✝¹ (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_lor_right2_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (const? 1) (select e✝ (const? 1) e✝¹) ⊑ select e✝¹ (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_bor_right1_thm (e✝ e✝¹ : IntW 1) : LLVM.or e✝¹ (select e✝¹ (const? 1) e✝) ⊑ select e✝¹ (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lor_bor_right2_thm (e✝ e✝¹ : IntW 1) : LLVM.or e✝¹ (select e✝ (const? 1) e✝¹) ⊑ select e✝ (const? 1) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bor_land_right1_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (LLVM.or e✝¹ e✝) (const? 0) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bor_land_right2_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (LLVM.or e✝ e✝¹) (const? 0) ⊑ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bor_lor_right1_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (const? 1) (LLVM.or e✝¹ e✝) ⊑ select e✝¹ (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bor_lor_right2_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (const? 1) (LLVM.or e✝ e✝¹) ⊑ select e✝¹ (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


