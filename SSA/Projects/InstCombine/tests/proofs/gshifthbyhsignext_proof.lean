
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthbyhsignext_proof
theorem t0_shl_thm (e✝ : IntW 8) (e✝¹ : IntW 32) : shl e✝¹ (sext 32 e✝) ⊑ shl e✝¹ (zext 32 e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_lshr_thm (e✝ : IntW 8) (e✝¹ : IntW 32) : lshr e✝¹ (sext 32 e✝) ⊑ lshr e✝¹ (zext 32 e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_ashr_thm (e✝ : IntW 8) (e✝¹ : IntW 32) : ashr e✝¹ (sext 32 e✝) ⊑ ashr e✝¹ (zext 32 e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


