
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubhnot_proof
theorem sub_not_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (sub e✝¹ e✝) (const? (-1)) ⊑ add e✝ (LLVM.xor e✝¹ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem dec_sub_thm (e✝ e✝¹ : IntW 8) : add (sub e✝¹ e✝) (const? (-1)) ⊑ add e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_inc_thm (e✝ e✝¹ : IntW 8) : sub e✝¹ (add e✝ (const? 1)) ⊑ add e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_dec_thm (e✝ e✝¹ : IntW 8) : sub (add e✝¹ (const? (-1))) e✝ ⊑ add e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


