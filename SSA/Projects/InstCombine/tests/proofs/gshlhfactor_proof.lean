
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshlhfactor_proof
theorem add_shl_same_amount_thm : ∀ (e e_1 e_2 : IntW 6), add (shl e_2 e_1) (shl e e_1) ⊑ shl (add e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_nuw_thm : ∀ (e e_1 e_2 : IntW 64), add (shl e_2 e_1) (shl e e_1) ⊑ shl (add e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_partial_nsw1_thm : ∀ (e e_1 e_2 : IntW 6), add (shl e_2 e_1) (shl e e_1) ⊑ shl (add e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_partial_nsw2_thm : ∀ (e e_1 e_2 : IntW 6), add (shl e_2 e_1) (shl e e_1) ⊑ shl (add e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_partial_nuw1_thm : ∀ (e e_1 e_2 : IntW 6), add (shl e_2 e_1) (shl e e_1) ⊑ shl (add e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_partial_nuw2_thm : ∀ (e e_1 e_2 : IntW 6), add (shl e_2 e_1) (shl e e_1) ⊑ shl (add e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_thm : ∀ (e e_1 e_2 : IntW 6), sub (shl e_2 e_1) (shl e e_1) ⊑ shl (sub e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_nuw_thm : ∀ (e e_1 e_2 : IntW 64), sub (shl e_2 e_1) (shl e e_1) ⊑ shl (sub e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_partial_nsw1_thm : ∀ (e e_1 e_2 : IntW 6), sub (shl e_2 e_1) (shl e e_1) ⊑ shl (sub e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_partial_nsw2_thm : ∀ (e e_1 e_2 : IntW 6), sub (shl e_2 e_1) (shl e e_1) ⊑ shl (sub e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_partial_nuw1_thm : ∀ (e e_1 e_2 : IntW 6), sub (shl e_2 e_1) (shl e e_1) ⊑ shl (sub e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_partial_nuw2_thm : ∀ (e e_1 e_2 : IntW 6), sub (shl e_2 e_1) (shl e e_1) ⊑ shl (sub e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_constants_thm : ∀ (e : IntW 8), add (shl (const? 4) e) (shl (const? 3) e) ⊑ shl (const? 7) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


