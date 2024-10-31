
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gpr53357_proof
theorem src_thm (e✝ e✝¹ : IntW 32) :
  add (LLVM.and e✝¹ e✝) (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) ⊑ LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src2_thm (e✝ e✝¹ : IntW 32) :
  add (LLVM.and e✝¹ e✝) (LLVM.xor (LLVM.or e✝ e✝¹) (const? (-1))) ⊑ LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src3_thm (e✝ e✝¹ : IntW 32) :
  add (LLVM.and e✝¹ e✝) (LLVM.and (LLVM.xor e✝ (const? (-1))) (LLVM.xor e✝¹ (const? (-1)))) ⊑
    LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src4_thm (e✝ e✝¹ : IntW 32) :
  add (LLVM.and e✝¹ e✝) (LLVM.xor (LLVM.or e✝ e✝¹) (const? (-1))) ⊑ LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem src5_thm (e✝ e✝¹ : IntW 32) :
  add (LLVM.xor (LLVM.or e✝¹ e✝) (const? (-1))) (LLVM.and e✝¹ e✝) ⊑ LLVM.xor (LLVM.xor e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


