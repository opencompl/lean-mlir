
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gdistribute_proof
theorem factorize_thm (e✝ : IntW 32) : LLVM.and (LLVM.or e✝ (const? 1)) (LLVM.or e✝ (const? 2)) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem factorize2_thm (e✝ : IntW 32) : sub (mul (const? 3) e✝) (mul (const? 2) e✝) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem factorize3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or e✝² (LLVM.or e✝¹ e✝)) (LLVM.or e✝² e✝) ⊑ LLVM.or e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem factorize4_thm (e✝ e✝¹ : IntW 32) : sub (mul (shl e✝¹ (const? 1)) e✝) (mul e✝ e✝¹) ⊑ mul e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem factorize5_thm (e✝ e✝¹ : IntW 32) : sub (mul (mul e✝¹ (const? 2)) e✝) (mul e✝ e✝¹) ⊑ mul e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem expand_thm (e✝ : IntW 32) :
  LLVM.and (LLVM.or (LLVM.and e✝ (const? 1)) (const? 2)) (const? 1) ⊑ LLVM.and e✝ (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


