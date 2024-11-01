
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gfoldhsubhofhnothtohinchofhadd_proof
theorem p0_scalar_thm (e e_1 : IntW 32) : sub e_1 (LLVM.xor e (const? 32 (-1))) ⊑ add (add e (const? 32 1)) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


