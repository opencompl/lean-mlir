
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gfoldhsubhofhnothtohinchofhadd_proof
theorem p0_scalar_thm (e✝ e✝¹ : IntW 32) : sub e✝¹ (LLVM.xor e✝ (const? (-1))) ⊑ add (add e✝ (const? 1)) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


