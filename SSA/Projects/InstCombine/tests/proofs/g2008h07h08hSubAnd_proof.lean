
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2008h07h08hSubAnd_proof
theorem a_thm :
  ∀ (e : IntW 32), LLVM.and (sub (const? 8) e) (const? 7) ⊑ LLVM.and (sub (const? 0) e) (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


