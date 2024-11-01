
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gxorhandhor_proof
theorem xor_logic_and_logic_or1_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.xor (select e✝² e✝¹ (const? 0)) (select e✝² (const? 1) e✝) ⊑ select e✝² (LLVM.xor e✝¹ (const? 1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_logic_and_logic_or2_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.xor (select e✝² e✝¹ (const? 0)) (select e✝ (const? 1) e✝²) ⊑ select e✝² (LLVM.xor e✝¹ (const? 1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_logic_and_logic_or4_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.xor (select e✝² e✝¹ (const? 0)) (select e✝¹ (const? 1) e✝) ⊑ select e✝¹ (LLVM.xor e✝² (const? 1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_and_logic_or1_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.xor (LLVM.and e✝² e✝¹) (select e✝² (const? 1) e✝) ⊑ select e✝² (LLVM.xor e✝¹ (const? 1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_and_logic_or2_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.xor (LLVM.and e✝² e✝¹) (select e✝ (const? 1) e✝¹) ⊑ select e✝¹ (LLVM.xor e✝² (const? 1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_logic_and_or1_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.xor (select e✝² e✝¹ (const? 0)) (LLVM.or e✝ e✝²) ⊑ select e✝² (LLVM.xor e✝¹ (const? 1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_logic_and_or2_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.xor (select e✝² e✝¹ (const? 0)) (LLVM.or e✝¹ e✝) ⊑ select e✝¹ (LLVM.xor e✝² (const? 1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_and_or_thm (e✝ e✝¹ e✝² : IntW 1) :
  LLVM.xor (LLVM.and e✝² e✝¹) (LLVM.or e✝ e✝²) ⊑ select e✝² (LLVM.xor e✝¹ (const? 1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


