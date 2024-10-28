
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h07h11hRemAnd_proof
theorem a_thm : ∀ (e : IntW 32), LLVM.and (LLVM.srem e (const? 8)) (const? 1) ⊑ LLVM.and e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


