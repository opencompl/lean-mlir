
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmaskedhmergehor_proof
theorem p_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and e✝² e✝¹) (LLVM.and (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑
    LLVM.or (LLVM.and e✝² e✝¹) (LLVM.and e✝ (LLVM.xor e✝¹ (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p_commutative0_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and e✝² e✝¹) (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝) ⊑
    LLVM.or (LLVM.and e✝² e✝¹) (LLVM.and e✝ (LLVM.xor e✝² (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p_commutative2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) (LLVM.and e✝ e✝²) ⊑
    LLVM.or (LLVM.and e✝¹ (LLVM.xor e✝² (const? (-1)))) (LLVM.and e✝ e✝²) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p_commutative4_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.or (LLVM.and (LLVM.xor e✝² (const? (-1))) e✝¹) (LLVM.and e✝² e✝) ⊑
    LLVM.or (LLVM.and e✝¹ (LLVM.xor e✝² (const? (-1)))) (LLVM.and e✝² e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n2_badmask_thm (e✝ e✝¹ e✝² e✝³ : IntW 32) :
  LLVM.or (LLVM.and e✝³ e✝²) (LLVM.and (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑
    LLVM.or (LLVM.and e✝³ e✝²) (LLVM.and e✝ (LLVM.xor e✝¹ (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n3_constmask_samemask_thm (e✝ e✝¹ : IntW 32) :
  LLVM.or (LLVM.and e✝¹ (const? 65280)) (LLVM.and e✝ (const? 65280)) ⊑ LLVM.and (LLVM.or e✝¹ e✝) (const? 65280) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


