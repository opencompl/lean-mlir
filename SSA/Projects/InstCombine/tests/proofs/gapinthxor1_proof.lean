
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthxor1_proof
theorem test1_thm (e✝ e✝¹ : IntW 47) :
  LLVM.xor (LLVM.and e✝¹ (const? (-70368744177664))) (LLVM.and e✝ (const? 70368744177661)) ⊑
    LLVM.or (LLVM.and e✝¹ (const? (-70368744177664))) (LLVM.and e✝ (const? 70368744177661)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ : IntW 15) : LLVM.xor e✝ (const? 0) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e✝ : IntW 23) : LLVM.xor e✝ e✝ ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e✝ : IntW 37) : LLVM.xor e✝ (LLVM.xor (const? (-1)) e✝) ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e✝ : IntW 7) : LLVM.xor (LLVM.or e✝ (const? 23)) (const? 23) ⊑ LLVM.and e✝ (const? (-24)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm (e✝ : IntW 7) : LLVM.xor (LLVM.xor e✝ (const? 23)) (const? 23) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e✝ : IntW 47) :
  LLVM.xor (LLVM.or e✝ (const? 70368744177663)) (const? 703687463) ⊑
    LLVM.or (LLVM.and e✝ (const? (-70368744177664))) (const? 70368040490200) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


