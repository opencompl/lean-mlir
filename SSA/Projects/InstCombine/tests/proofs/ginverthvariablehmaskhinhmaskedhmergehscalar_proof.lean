
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section ginverthvariablehmaskhinhmaskedhmergehscalar_proof
theorem scalar_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) (LLVM.xor e✝ (const? (-1)))) e✝¹ ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) e✝) e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem in_constant_varx_mone_invmask_thm (e✝ e✝¹ : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e✝¹ (const? (-1))) (LLVM.xor e✝ (const? (-1)))) (const? (-1)) ⊑ LLVM.or e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem in_constant_varx_6_invmask_thm (e✝ e✝¹ : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e✝¹ (const? 6)) (LLVM.xor e✝ (const? (-1)))) (const? 6) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝¹ (const? 6)) e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem in_constant_mone_vary_invmask_thm (e✝ e✝¹ : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor (const? (-1)) e✝¹) (LLVM.xor e✝ (const? (-1)))) e✝¹ ⊑
    LLVM.or e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem in_constant_6_vary_invmask_thm (e✝ e✝¹ : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e✝¹ (const? 6)) (LLVM.xor e✝ (const? (-1)))) e✝¹ ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝¹ (const? 6)) e✝) (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem c_1_0_0_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) (LLVM.xor e✝ (const? (-1)))) e✝² ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem c_0_1_0_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) (LLVM.xor e✝ (const? (-1)))) e✝² ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem c_1_1_0_thm (e✝ e✝¹ e✝² : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) (LLVM.xor e✝ (const? (-1)))) e✝¹ ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝² e✝¹) e✝) e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem commutativity_constant_varx_6_invmask_thm (e✝ e✝¹ : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e✝¹ (const? (-1))) (LLVM.xor e✝ (const? 6))) (const? 6) ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝ (const? 6)) e✝¹) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem commutativity_constant_6_vary_invmask_thm (e✝ e✝¹ : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e✝¹ (const? (-1))) (LLVM.xor e✝ (const? 6))) e✝ ⊑
    LLVM.xor (LLVM.and (LLVM.xor e✝ (const? 6)) e✝¹) (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


