
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section ghoisthnothfromhashrhoperand_proof
theorem t0_thm (e✝ e✝¹ : IntW 8) :
  ashr (LLVM.xor e✝¹ (const? (-1))) e✝ ⊑ LLVM.xor (ashr e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_thm (e✝ e✝¹ : IntW 8) :
  ashr (LLVM.xor e✝¹ (const? (-1))) e✝ ⊑ LLVM.xor (ashr e✝¹ e✝) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


