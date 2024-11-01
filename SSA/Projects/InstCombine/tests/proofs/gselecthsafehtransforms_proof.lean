
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthsafehtransforms_proof
theorem bools_logical_commute0_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select (LLVM.xor e✝² (const? 1)) e✝¹ (const? 0)) (const? 1) (select e✝² e✝ (const? 0)) ⊑
    select e✝² e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute0_and1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and (LLVM.xor e✝² (const? 1)) e✝¹) (const? 1) (select e✝² e✝ (const? 0)) ⊑ select e✝² e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute0_and2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select (LLVM.xor e✝² (const? 1)) e✝¹ (const? 0)) (const? 1) (LLVM.and e✝² e✝) ⊑ select e✝² e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute0_and1_and2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and (LLVM.xor e✝² (const? 1)) e✝¹) (const? 1) (LLVM.and e✝² e✝) ⊑ select e✝² e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (LLVM.xor e✝¹ (const? 1)) (const? 0)) (const? 1) (select e✝¹ e✝ (const? 0)) ⊑
    select e✝¹ e✝ e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute1_and2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (LLVM.xor e✝¹ (const? 1)) (const? 0)) (const? 1) (LLVM.and e✝¹ e✝) ⊑ select e✝¹ e✝ e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute3_and2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² (LLVM.xor e✝¹ (const? 1)) (const? 0)) (const? 1) (LLVM.and e✝ e✝¹) ⊑ select e✝¹ e✝ e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute0_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select (LLVM.xor e✝² (const? 1)) e✝ (const? 0)) ⊑
    select e✝² e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute0_and1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (select (LLVM.xor e✝² (const? 1)) e✝ (const? 0)) ⊑ select e✝² e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute0_and2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (LLVM.and (LLVM.xor e✝² (const? 1)) e✝) ⊑ select e✝² e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute0_and1_and2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (LLVM.and (LLVM.xor e✝² (const? 1)) e✝) ⊑ select e✝² e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select (LLVM.xor e✝¹ (const? 1)) e✝ (const? 0)) ⊑
    select e✝¹ e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute1_and1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (select (LLVM.xor e✝¹ (const? 1)) e✝ (const? 0)) ⊑ select e✝¹ e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute1_and2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (LLVM.and (LLVM.xor e✝¹ (const? 1)) e✝) ⊑ select e✝¹ e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute1_and1_and2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (LLVM.and (LLVM.xor e✝¹ (const? 1)) e✝) ⊑ select e✝¹ e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select e✝ (LLVM.xor e✝² (const? 1)) (const? 0)) ⊑
    select e✝² e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute2_and1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (select e✝ (LLVM.xor e✝² (const? 1)) (const? 0)) ⊑ select e✝² e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute3_nopoison_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (select e✝² e✝¹ (const? 0)) (const? 1) (select e✝ (LLVM.xor e✝¹ (const? 1)) (const? 0)) ⊑
    select e✝¹ e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute3_and1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² e✝¹) (const? 1) (select e✝ (LLVM.xor e✝¹ (const? 1)) (const? 0)) ⊑ select e✝¹ e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


