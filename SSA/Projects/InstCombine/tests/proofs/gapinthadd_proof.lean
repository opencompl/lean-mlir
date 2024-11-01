
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthadd_proof
theorem test1_thm (e✝ : IntW 1) : add (LLVM.xor e✝ (const? 1)) (const? 1) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ : IntW 47) :
  add (LLVM.xor e✝ (const? (-70368744177664))) (const? (-70368744177664)) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e✝ : IntW 15) : add (LLVM.xor e✝ (const? (-16384))) (const? (-16384)) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e✝ : IntW 49) : add (LLVM.and e✝ (const? (-2))) (const? 1) ⊑ LLVM.or e✝ (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_thm (e✝ : IntW 4) :
  add (zext 7 (LLVM.xor e✝ (const? (-8)))) (const? (-8)) { «nsw» := true, «nuw» := false } ⊑ sext 7 e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_multiuse_thm (e✝ : IntW 4) :
  LLVM.sdiv
      (trunc 4
        (LLVM.sdiv (zext 7 (LLVM.xor e✝ (const? (-8))))
          (add (zext 7 (LLVM.xor e✝ (const? (-8)))) (const? (-8)) { «nsw» := true, «nuw» := false })))
      (LLVM.xor e✝ (const? (-8))) ⊑
    LLVM.sdiv (trunc 4 (LLVM.sdiv (zext 7 (LLVM.xor e✝ (const? (-8)))) (sext 7 e✝)))
      (LLVM.xor e✝ (const? (-8))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e✝ : IntW 111) :
  add (LLVM.xor e✝ (shl (const? 1) (const? 110))) (shl (const? 1) (const? 110)) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm (e✝ : IntW 65) :
  add (LLVM.xor e✝ (shl (const? 1) (const? 64))) (shl (const? 1) (const? 64)) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e✝ : IntW 1024) :
  add (LLVM.xor e✝ (shl (const? 1) (const? 1023))) (shl (const? 1) (const? 1023)) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm (e✝ : IntW 128) :
  add (LLVM.xor e✝ (ashr (shl (const? 1) (const? 127)) (const? 120))) (shl (const? 1) (const? 127)) ⊑
    LLVM.xor e✝ (const? 170141183460469231731687303715884105600) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm (e✝ : IntW 77) :
  add (LLVM.and e✝ (const? 562949953421310)) (const? 1) ⊑
    LLVM.or (LLVM.and e✝ (const? 562949953421310)) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


