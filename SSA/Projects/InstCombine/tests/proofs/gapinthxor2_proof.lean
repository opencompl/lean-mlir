
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthxor2_proof
theorem test1_thm (e e_1 : IntW 447) :
  LLVM.xor (LLVM.and e_1 (const? 70368744177664)) (LLVM.and e (const? 70368744177663)) ⊑
    LLVM.or (LLVM.and e_1 (const? 70368744177664)) (LLVM.and e (const? 70368744177663)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e : IntW 1005) : LLVM.xor e (const? 0) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e : IntW 123) : LLVM.xor e e ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e : IntW 737) : LLVM.xor e (LLVM.xor (const? (-1)) e) ⊑ const? (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e : IntW 700) :
  LLVM.xor (LLVM.or e (const? 288230376151711743)) (const? 288230376151711743) ⊑
    LLVM.and e (const? (-288230376151711744)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm (e : IntW 77) : LLVM.xor (LLVM.xor e (const? 23)) (const? 23) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e : IntW 1023) :
  LLVM.xor (LLVM.or e (const? 70368744177663)) (const? 703687463) ⊑
    LLVM.or (LLVM.and e (const? (-70368744177664))) (const? 70368040490200) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


