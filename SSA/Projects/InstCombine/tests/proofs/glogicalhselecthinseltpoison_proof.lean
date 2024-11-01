
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section glogicalhselecthinseltpoison_proof
theorem bools_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.or (LLVM.and (LLVM.xor e✝² (const? 1)) e✝¹) (LLVM.and e✝² e✝) ⊑ select e✝² e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select (LLVM.xor e✝² (const? 1)) e✝¹ (const? 0)) (const? 1) (select e✝² e✝ (const? 0)) ⊑
    select e✝² e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_multi_uses1_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.xor (LLVM.or (LLVM.and (LLVM.xor e✝² (const? 1)) e✝¹) (LLVM.and e✝² e✝))
      (LLVM.and (LLVM.xor e✝² (const? 1)) e✝¹) ⊑
    LLVM.xor (select e✝² e✝ e✝¹) (LLVM.and e✝¹ (LLVM.xor e✝² (const? 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_multi_uses1_logical_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.xor (select (select (LLVM.xor e✝² (const? 1)) e✝¹ (const? 0)) (const? 1) (select e✝² e✝ (const? 0)))
      (select (LLVM.xor e✝² (const? 1)) e✝¹ (const? 0)) ⊑
    LLVM.xor (select e✝² e✝ e✝¹) (select (LLVM.xor e✝² (const? 1)) e✝¹ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_multi_uses2_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.and (LLVM.or (LLVM.and (LLVM.xor e✝² (const? 1)) e✝¹) (LLVM.and e✝² e✝))
      (add (LLVM.and (LLVM.xor e✝² (const? 1)) e✝¹) (LLVM.and e✝² e✝)) ⊑
    select e✝² e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_multi_uses2_logical_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select (select (LLVM.xor e✝² (const? 1)) e✝¹ (const? 0)) (const? 1) (select e✝² e✝ (const? 0)))
      (add (select (LLVM.xor e✝² (const? 1)) e✝¹ (const? 0)) (select e✝² e✝ (const? 0))) (const? 0) ⊑
    select (select e✝² e✝ e✝¹) (LLVM.xor (select (LLVM.xor e✝² (const? 1)) e✝¹ (const? 0)) (select e✝² e✝ (const? 0)))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


