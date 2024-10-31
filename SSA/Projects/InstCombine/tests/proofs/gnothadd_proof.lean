
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gnothadd_proof
theorem basic_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (add (LLVM.xor e✝¹ (const? (-1))) e✝) (const? (-1)) ⊑ sub e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem basic_com_add_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (add e✝¹ (LLVM.xor e✝ (const? (-1)))) (const? (-1)) ⊑ sub e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem basic_preserve_nsw_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (add (LLVM.xor e✝¹ (const? (-1))) e✝ { «nsw» := true, «nuw» := false }) (const? (-1)) ⊑
    sub e✝¹ e✝ { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem basic_preserve_nuw_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (add (LLVM.xor e✝¹ (const? (-1))) e✝ { «nsw» := false, «nuw» := true }) (const? (-1)) ⊑
    sub e✝¹ e✝ { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem basic_preserve_nuw_nsw_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (add (LLVM.xor e✝¹ (const? (-1))) e✝ { «nsw» := true, «nuw» := true }) (const? (-1)) ⊑
    sub e✝¹ e✝ { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


