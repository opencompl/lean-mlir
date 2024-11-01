
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthsra_proof
theorem test1_thm (e✝ : IntW 8) (e✝¹ : IntW 32) :
  LLVM.and (ashr e✝¹ (zext 32 e✝)) (const? 1) ⊑ LLVM.and (lshr e✝¹ (zext 32 e✝)) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ : IntW 8) :
  ashr (add (zext 32 e✝) (const? 7)) (const? 3) ⊑
    lshr (add (zext 32 e✝) (const? 7) { «nsw» := true, «nuw» := true }) (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_ashr_thm (e✝ : IntW 32) : ashr (ashr e✝ (const? 5)) (const? 7) ⊑ ashr e✝ (const? 12) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_overshift_thm (e✝ : IntW 32) : ashr (ashr e✝ (const? 15)) (const? 17) ⊑ ashr e✝ (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem hoist_ashr_ahead_of_sext_1_thm (e✝ : IntW 8) : ashr (sext 32 e✝) (const? 3) ⊑ sext 32 (ashr e✝ (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem hoist_ashr_ahead_of_sext_2_thm (e✝ : IntW 8) : ashr (sext 32 e✝) (const? 8) ⊑ sext 32 (ashr e✝ (const? 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


