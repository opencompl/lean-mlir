
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshouldhchangehtype_proof
theorem test1_thm (e✝ e✝¹ : IntW 8) : trunc 8 (add (zext 64 e✝¹) (zext 64 e✝)) ⊑ add e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ e✝¹ : IntW 16) : trunc 16 (add (zext 64 e✝¹) (zext 64 e✝)) ⊑ add e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e✝ e✝¹ : IntW 32) : trunc 32 (add (zext 64 e✝¹) (zext 64 e✝)) ⊑ add e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e✝ e✝¹ : IntW 9) :
  trunc 9 (add (zext 64 e✝¹) (zext 64 e✝)) ⊑
    trunc 9 (add (zext 64 e✝¹) (zext 64 e✝) { «nsw» := true, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


