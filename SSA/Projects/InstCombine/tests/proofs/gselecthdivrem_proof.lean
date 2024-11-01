
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthdivrem_proof
theorem udiv_common_divisor_thm (e✝ e✝¹ e✝² : IntW 5) (e✝³ : IntW 1) :
  select e✝³ (LLVM.udiv e✝² e✝¹) (LLVM.udiv e✝ e✝¹) ⊑ LLVM.udiv (select e✝³ e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_common_divisor_thm (e✝ e✝¹ e✝² : IntW 5) (e✝³ : IntW 1) :
  select e✝³ (urem e✝² e✝¹) (urem e✝ e✝¹) ⊑ urem (select e✝³ e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_common_divisor_defined_cond_thm (e✝ e✝¹ e✝² : IntW 5) (e✝³ : IntW 1) :
  select e✝³ (LLVM.sdiv e✝² e✝¹) (LLVM.sdiv e✝ e✝¹) ⊑ LLVM.sdiv (select e✝³ e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem srem_common_divisor_defined_cond_thm (e✝ e✝¹ e✝² : IntW 5) (e✝³ : IntW 1) :
  select e✝³ (LLVM.srem e✝² e✝¹) (LLVM.srem e✝ e✝¹) ⊑ LLVM.srem (select e✝³ e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_common_divisor_defined_cond_thm (e✝ e✝¹ e✝² : IntW 5) (e✝³ : IntW 1) :
  select e✝³ (LLVM.udiv e✝² e✝¹) (LLVM.udiv e✝ e✝¹) ⊑ LLVM.udiv (select e✝³ e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_common_divisor_defined_cond_thm (e✝ e✝¹ e✝² : IntW 5) (e✝³ : IntW 1) :
  select e✝³ (urem e✝² e✝¹) (urem e✝ e✝¹) ⊑ urem (select e✝³ e✝² e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_common_dividend_defined_cond_thm (e✝ e✝¹ e✝² : IntW 5) (e✝³ : IntW 1) :
  select e✝³ (LLVM.sdiv e✝² e✝¹) (LLVM.sdiv e✝² e✝) ⊑ LLVM.sdiv e✝² (select e✝³ e✝¹ e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem srem_common_dividend_defined_cond_thm (e✝ e✝¹ e✝² : IntW 5) (e✝³ : IntW 1) :
  select e✝³ (LLVM.srem e✝² e✝¹) (LLVM.srem e✝² e✝) ⊑ LLVM.srem e✝² (select e✝³ e✝¹ e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_common_dividend_defined_cond_thm (e✝ e✝¹ e✝² : IntW 5) (e✝³ : IntW 1) :
  select e✝³ (LLVM.udiv e✝² e✝¹) (LLVM.udiv e✝² e✝) ⊑ LLVM.udiv e✝² (select e✝³ e✝¹ e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_common_dividend_defined_cond_thm (e✝ e✝¹ e✝² : IntW 5) (e✝³ : IntW 1) :
  select e✝³ (urem e✝² e✝¹) (urem e✝² e✝) ⊑ urem e✝² (select e✝³ e✝¹ e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


