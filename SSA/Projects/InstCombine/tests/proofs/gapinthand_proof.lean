
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthand_proof
theorem test0_thm : ∀ (e : IntW 39), LLVM.and e (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm : ∀ (e : IntW 15), LLVM.and e (const? (-1)) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm : ∀ (e : IntW 23), LLVM.and (LLVM.and e (const? 127)) (const? 128) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm : ∀ (e : IntW 47), LLVM.and (ashr e (const? 39)) (const? 255) ⊑ lshr e (const? 39) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm : ∀ (e : IntW 999), LLVM.and e (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm : ∀ (e : IntW 1005), LLVM.and e (const? (-1)) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm : ∀ (e : IntW 123), LLVM.and (LLVM.and e (const? 127)) (const? 128) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm : ∀ (e : IntW 1024), LLVM.and (ashr e (const? 1016)) (const? 255) ⊑ lshr e (const? 1016) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


