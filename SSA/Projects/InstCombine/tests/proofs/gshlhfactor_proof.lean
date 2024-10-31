
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshlhfactor_proof
theorem add_shl_same_amount_thm (e✝ e✝¹ e✝² : IntW 6) : add (shl e✝² e✝¹) (shl e✝ e✝¹) ⊑ shl (add e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_nuw_thm (e✝ e✝¹ e✝² : IntW 64) :
  add (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (shl e✝ e✝¹ { «nsw» := false, «nuw» := true })
      { «nsw» := false, «nuw» := true } ⊑
    shl (add e✝² e✝ { «nsw» := false, «nuw» := true }) e✝¹ { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_partial_nsw1_thm (e✝ e✝¹ e✝² : IntW 6) :
  add (shl e✝² e✝¹ { «nsw» := true, «nuw» := false }) (shl e✝ e✝¹ { «nsw» := true, «nuw» := false }) ⊑
    shl (add e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_partial_nsw2_thm (e✝ e✝¹ e✝² : IntW 6) :
  add (shl e✝² e✝¹) (shl e✝ e✝¹ { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    shl (add e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_partial_nuw1_thm (e✝ e✝¹ e✝² : IntW 6) :
  add (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (shl e✝ e✝¹ { «nsw» := false, «nuw» := true }) ⊑
    shl (add e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_partial_nuw2_thm (e✝ e✝¹ e✝² : IntW 6) :
  add (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (shl e✝ e✝¹) { «nsw» := false, «nuw» := true } ⊑
    shl (add e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_thm (e✝ e✝¹ e✝² : IntW 6) : sub (shl e✝² e✝¹) (shl e✝ e✝¹) ⊑ shl (sub e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_nuw_thm (e✝ e✝¹ e✝² : IntW 64) :
  sub (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (shl e✝ e✝¹ { «nsw» := false, «nuw» := true })
      { «nsw» := false, «nuw» := true } ⊑
    shl (sub e✝² e✝ { «nsw» := false, «nuw» := true }) e✝¹ { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_partial_nsw1_thm (e✝ e✝¹ e✝² : IntW 6) :
  sub (shl e✝² e✝¹ { «nsw» := true, «nuw» := false }) (shl e✝ e✝¹ { «nsw» := true, «nuw» := false }) ⊑
    shl (sub e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_partial_nsw2_thm (e✝ e✝¹ e✝² : IntW 6) :
  sub (shl e✝² e✝¹) (shl e✝ e✝¹ { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    shl (sub e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_partial_nuw1_thm (e✝ e✝¹ e✝² : IntW 6) :
  sub (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (shl e✝ e✝¹ { «nsw» := false, «nuw» := true }) ⊑
    shl (sub e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_shl_same_amount_partial_nuw2_thm (e✝ e✝¹ e✝² : IntW 6) :
  sub (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (shl e✝ e✝¹) { «nsw» := false, «nuw» := true } ⊑
    shl (sub e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_shl_same_amount_constants_thm (e✝ : IntW 8) : add (shl (const? 4) e✝) (shl (const? 3) e✝) ⊑ shl (const? 7) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


