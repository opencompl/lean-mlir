
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gredundanthrighthshifthinputhmasking_proof
theorem t0_lshr_thm (e✝ e✝¹ : IntW 32) :
  lshr (LLVM.and (shl (const? (-1)) e✝¹) e✝) e✝¹ ⊑
    lshr (LLVM.and (shl (const? (-1)) e✝¹ { «nsw» := true, «nuw» := false }) e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_sshr_thm (e✝ e✝¹ : IntW 32) :
  ashr (LLVM.and (shl (const? (-1)) e✝¹) e✝) e✝¹ ⊑
    ashr (LLVM.and (shl (const? (-1)) e✝¹ { «nsw» := true, «nuw» := false }) e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n13_thm (e✝ e✝¹ e✝² : IntW 32) :
  lshr (LLVM.and (shl (const? (-1)) e✝²) e✝¹) e✝ ⊑
    lshr (LLVM.and (shl (const? (-1)) e✝² { «nsw» := true, «nuw» := false }) e✝¹) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


