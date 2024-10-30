
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h05h31hAddBool_proof
theorem test_thm : ∀ (e e_1 : IntW 1), add e_1 e ⊑ LLVM.xor e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


