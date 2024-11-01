
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gconditionalhnegation_proof
theorem t0_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  LLVM.xor (add (sext 8 e✝¹) e✝) (sext 8 e✝¹) ⊑ select e✝¹ (sub (const? 0) e✝) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  LLVM.xor (add (sext 8 e✝¹) e✝) (sext 8 e✝¹) ⊑ select e✝¹ (sub (const? 0) e✝) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_thm (e✝ : IntW 1) (e✝¹ : IntW 8) (e✝² : IntW 1) :
  LLVM.xor (add (sext 8 e✝²) e✝¹) (sext 8 e✝) ⊑ LLVM.xor (add e✝¹ (sext 8 e✝²)) (sext 8 e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t3_thm (e✝ : IntW 8) (e✝¹ : IntW 2) :
  LLVM.xor (add (sext 8 e✝¹) e✝) (sext 8 e✝¹) ⊑ LLVM.xor (add e✝ (sext 8 e✝¹)) (sext 8 e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


