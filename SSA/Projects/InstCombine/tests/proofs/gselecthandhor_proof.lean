
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthandhor_proof
theorem logical_and_not_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (const? 0) e✝ ⊑ select (LLVM.xor e✝¹ (const? 1)) e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_not_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ e✝ (const? 1) ⊑ select (LLVM.xor e✝¹ (const? 1)) (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_cond_reuse_thm (e✝ e✝¹ : IntW 1) : select e✝¹ e✝ e✝¹ ⊑ select e✝¹ e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_cond_reuse_thm (e✝ e✝¹ : IntW 1) : select e✝¹ e✝¹ e✝ ⊑ select e✝¹ (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_not_cond_reuse_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ e✝ (LLVM.xor e✝¹ (const? 1)) ⊑ select (LLVM.xor e✝¹ (const? 1)) (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_not_cond_reuse_thm (e✝ e✝¹ : IntW 1) :
  select e✝¹ (LLVM.xor e✝¹ (const? 1)) e✝ ⊑ select (LLVM.xor e✝¹ (const? 1)) e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_noundef_b_thm (e✝ e✝¹ : IntW 1) : select e✝¹ (const? 1) e✝ ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_noundef_b_thm (e✝ e✝¹ : IntW 1) : select e✝¹ e✝ (const? 0) ⊑ LLVM.and e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_not_true_thm (e✝ e✝¹ : IntW 1) :
  select (LLVM.xor e✝¹ (const? 1)) (LLVM.xor e✝ (const? 1)) (const? 1) ⊑
    select e✝¹ (const? 1) (LLVM.xor e✝ (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_not_false_thm (e✝ e✝¹ : IntW 1) :
  select (LLVM.xor e✝¹ (const? 1)) (LLVM.xor e✝ (const? 1)) (const? 0) ⊑
    LLVM.xor (select e✝¹ (const? 1) e✝) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_true_not_thm (e✝ e✝¹ : IntW 1) :
  select (LLVM.xor e✝¹ (const? 1)) (const? 1) (LLVM.xor e✝ (const? 1)) ⊑
    LLVM.xor (select e✝¹ e✝ (const? 0)) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_false_not_thm (e✝ e✝¹ : IntW 1) :
  select (LLVM.xor e✝¹ (const? 1)) (const? 0) (LLVM.xor e✝ (const? 1)) ⊑
    select e✝¹ (LLVM.xor e✝ (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.or (LLVM.xor e✝² (const? 1)) e✝¹) e✝² e✝ ⊑ select e✝² (select e✝¹ (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and (LLVM.xor e✝² (const? 1)) e✝¹) e✝ e✝¹ ⊑ select e✝¹ (select e✝² (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or1_commuted_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.or e✝² (LLVM.xor e✝¹ (const? 1))) e✝¹ e✝ ⊑ select e✝¹ (select e✝² (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or2_commuted_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² (LLVM.xor e✝¹ (const? 1))) e✝ e✝² ⊑ select e✝² (select e✝¹ (const? 1) e✝) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or1_wrong_operand_thm (e✝ e✝¹ e✝² e✝³ : IntW 1) :
  select (LLVM.or (LLVM.xor e✝³ (const? 1)) e✝²) e✝¹ e✝ ⊑ select (LLVM.or e✝² (LLVM.xor e✝³ (const? 1))) e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or2_wrong_operand_thm (e✝ e✝¹ e✝² e✝³ : IntW 1) :
  select (LLVM.and (LLVM.xor e✝³ (const? 1)) e✝²) e✝¹ e✝ ⊑
    select (LLVM.and e✝² (LLVM.xor e✝³ (const? 1))) e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and1_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and (LLVM.xor e✝² (const? 1)) e✝¹) e✝ e✝² ⊑ select e✝² (const? 1) (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and2_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.or (LLVM.xor e✝² (const? 1)) e✝¹) e✝¹ e✝ ⊑ select e✝¹ (const? 1) (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and1_commuted_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.and e✝² (LLVM.xor e✝¹ (const? 1))) e✝ e✝¹ ⊑ select e✝¹ (const? 1) (select e✝² e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and2_commuted_thm (e✝ e✝¹ e✝² : IntW 1) :
  select (LLVM.or e✝² (LLVM.xor e✝¹ (const? 1))) e✝² e✝ ⊑ select e✝² (const? 1) (select e✝¹ e✝ (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem pr64558_thm (e✝ e✝¹ : IntW 1) : select (LLVM.and (LLVM.xor e✝¹ (const? 1)) e✝) e✝ e✝¹ ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


