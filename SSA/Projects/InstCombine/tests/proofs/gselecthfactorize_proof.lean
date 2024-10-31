
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthfactorize_proof
theorem logic_and_logic_or_1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select e✝² e✝ (const? 0)) ⊑
    select e✝² (select e✝¹ (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_and_logic_or_2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select e✝¹ e✝ (const? 0)) ⊑
    select e✝¹ (select e✝² (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_and_logic_or_3_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select e✝ e✝¹ (const? 0)) ⊑
    select (select e✝² (const? 1) e✝) e✝¹ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_and_logic_or_4_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select e✝ e✝² (const? 0)) ⊑
    select e✝² (select e✝¹ (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_and_logic_or_5_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select e✝² e✝ (const? 0)) ⊑
    select e✝² (select e✝¹ (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_and_logic_or_6_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select e✝ e✝² (const? 0)) ⊑
    select e✝² (select e✝¹ (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_and_logic_or_7_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select e✝ e✝¹ (const? 0)) ⊑
    select (select e✝² (const? 1) e✝) e✝¹ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_and_logic_or_8_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select e✝¹ e✝ (const? 0)) ⊑
    select e✝¹ (select e✝² (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_logic_and_logic_or_1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (select e✝² e✝ (const? 0)) ⊑
    select e✝² (select e✝¹ (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_logic_and_logic_or_2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (select e✝ e✝² (const? 0)) ⊑
    select e✝² (select e✝¹ (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_logic_and_logic_or_3_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (select e✝¹ e✝ (const? 0)) ⊑
    select e✝¹ (select e✝² (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_logic_and_logic_or_4_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (select e✝ e✝¹ (const? 0)) ⊑
    select e✝¹ (select e✝² (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_logic_and_logic_or_5_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (LLVM.and e✝² e✝) ⊑
    select e✝² (select e✝¹ (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_logic_and_logic_or_6_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (LLVM.and e✝¹ e✝) ⊑ LLVM.and e✝¹ (select e✝² (const? 1) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_logic_and_logic_or_7_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (LLVM.and e✝ e✝²) ⊑
    select e✝² (select e✝¹ (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_logic_and_logic_or_8_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (LLVM.and e✝ e✝¹) ⊑ LLVM.and e✝¹ (select e✝² (const? 1) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_and_logic_or_1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (LLVM.and e✝² e✝) ⊑ LLVM.and e✝² (select e✝¹ (const? 1) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_and_logic_or_2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (LLVM.and e✝ e✝²) ⊑ LLVM.and e✝² (select e✝¹ (const? 1) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_or_logic_and_1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (select e✝² (const? 1) e✝) (const? 0) ⊑
    select e✝² (const? 1) (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_or_logic_and_2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (select e✝¹ (const? 1) e✝) (const? 0) ⊑
    select e✝¹ (const? 1) (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_or_logic_and_3_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (select e✝ (const? 1) e✝¹) (const? 0) ⊑
    select (select e✝² e✝ (const? 0)) (const? 1) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_or_logic_and_4_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (select e✝ (const? 1) e✝²) (const? 0) ⊑
    select e✝² (const? 1) (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_or_logic_and_5_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (select e✝² (const? 1) e✝) (const? 0) ⊑
    select e✝² (const? 1) (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_or_logic_and_6_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (select e✝ (const? 1) e✝²) (const? 0) ⊑
    select e✝² (const? 1) (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_or_logic_and_7_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (select e✝ (const? 1) e✝¹) (const? 0) ⊑
    select (select e✝² e✝ (const? 0)) (const? 1) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logic_or_logic_and_8_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (select e✝¹ (const? 1) e✝) (const? 0) ⊑
    select e✝¹ (const? 1) (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_logic_or_logic_and_1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.or e✝² e✝¹) (select e✝² (const? 1) e✝) (const? 0) ⊑
    select e✝² (const? 1) (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_logic_or_logic_and_2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.or e✝² e✝¹) (select e✝ (const? 1) e✝²) (const? 0) ⊑
    select e✝² (const? 1) (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_logic_or_logic_and_3_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (LLVM.or e✝² e✝) (const? 0) ⊑
    select e✝² (const? 1) (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_logic_or_logic_and_4_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (LLVM.or e✝¹ e✝) (const? 0) ⊑ LLVM.or e✝¹ (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_logic_or_logic_and_5_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.or e✝² e✝¹) (select e✝¹ (const? 1) e✝) (const? 0) ⊑
    select e✝¹ (const? 1) (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_logic_or_logic_and_6_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.or e✝² e✝¹) (select e✝ (const? 1) e✝¹) (const? 0) ⊑
    select e✝¹ (const? 1) (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_logic_or_logic_and_7_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (LLVM.or e✝ e✝²) (const? 0) ⊑
    select e✝² (const? 1) (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_logic_or_logic_and_8_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (const? 1) e✝¹) (LLVM.or e✝ e✝¹) (const? 0) ⊑ LLVM.or e✝¹ (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_or_logic_and_1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.or e✝² e✝¹) (LLVM.or e✝ e✝²) (const? 0) ⊑ LLVM.or e✝² (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_or_logic_and_2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.or e✝² e✝¹) (LLVM.or e✝¹ e✝) (const? 0) ⊑ LLVM.or e✝¹ (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


