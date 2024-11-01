
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmaskedhmergehandhofhors_proof
theorem p_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor e✝² (const? (-1))) e✝¹) (LLVM.or e✝ e✝²) ⊑
    LLVM.and (LLVM.or e✝¹ (LLVM.xor e✝² (const? (-1)))) (LLVM.or e✝ e✝²) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p_commutative2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.and (LLVM.or e✝² e✝¹) (LLVM.or (LLVM.xor e✝¹ (const? (-1))) e✝) ⊑
    LLVM.and (LLVM.or e✝² e✝¹) (LLVM.or e✝ (LLVM.xor e✝¹ (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n2_badmask_thm (e✝ e✝¹ e✝² e✝³ : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor e✝³ (const? (-1))) e✝²) (LLVM.or e✝¹ e✝) ⊑
    LLVM.and (LLVM.or e✝² (LLVM.xor e✝³ (const? (-1)))) (LLVM.or e✝¹ e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n3_constmask_samemask_thm (e✝ e✝¹ : IntW 32) :
  LLVM.and (LLVM.or e✝¹ (const? (-65281))) (LLVM.or e✝ (const? (-65281))) ⊑
    LLVM.or (LLVM.and e✝¹ e✝) (const? (-65281)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


