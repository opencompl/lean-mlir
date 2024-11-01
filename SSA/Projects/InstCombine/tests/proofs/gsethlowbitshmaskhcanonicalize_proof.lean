
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsethlowbitshmaskhcanonicalize_proof
theorem shl_add_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝) (const? (-1)) ⊑
    LLVM.xor (shl (const? (-1)) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_nsw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝) (const? (-1)) { «nsw» := true, «nuw» := false } ⊑
    LLVM.xor (shl (const? (-1)) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_nuw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝) (const? (-1)) { «nsw» := false, «nuw» := true } ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_nsw_nuw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝) (const? (-1)) { «nsw» := true, «nuw» := true } ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_add_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) ⊑
    LLVM.xor (shl (const? (-1)) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_add_nsw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) { «nsw» := true, «nuw» := false } ⊑
    LLVM.xor (shl (const? (-1)) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_add_nuw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) { «nsw» := false, «nuw» := true } ⊑
    const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_add_nsw_nuw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) { «nsw» := true, «nuw» := true } ⊑
    const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nuw_add_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }) (const? (-1)) ⊑
    LLVM.xor (shl (const? (-1)) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nuw_add_nsw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }) (const? (-1)) { «nsw» := true, «nuw» := false } ⊑
    LLVM.xor (shl (const? (-1)) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nuw_add_nuw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }) (const? (-1)) { «nsw» := false, «nuw» := true } ⊑
    const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nuw_add_nsw_nuw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }) (const? (-1)) { «nsw» := true, «nuw» := true } ⊑
    const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_nuw_add_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := true, «nuw» := true }) (const? (-1)) ⊑
    LLVM.xor (shl (const? (-1)) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_nuw_add_nsw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := true, «nuw» := true }) (const? (-1)) { «nsw» := true, «nuw» := false } ⊑
    LLVM.xor (shl (const? (-1)) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_nuw_add_nuw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := true, «nuw» := true }) (const? (-1)) { «nsw» := false, «nuw» := true } ⊑
    const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_nuw_add_nsw_nuw_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝ { «nsw» := true, «nuw» := true }) (const? (-1)) { «nsw» := true, «nuw» := true } ⊑
    const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bad_add0_thm (e✝ e✝¹ : IntW 32) :
  add (shl (const? 1) e✝¹) e✝ ⊑ add (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true }) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bad_add1_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝) (const? 1) ⊑
    add (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }) (const? 1) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bad_add2_thm (e✝ : IntW 32) :
  add (shl (const? 1) e✝) (const? (-2)) ⊑
    add (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


