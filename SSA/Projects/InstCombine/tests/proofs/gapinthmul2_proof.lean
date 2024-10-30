
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthmul2_proof
theorem test1_thm : ∀ (e : IntW 177), mul e (shl (const? 1) (const? 155)) ⊑ shl e (const? 155) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


