
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section ghoisthnegationhouthofhbiashcalculationhwithhconstant_proof
theorem t0_thm (e✝ : IntW 8) :
  sub (LLVM.and e✝ (const? 42)) e✝ ⊑ sub (const? 0) (LLVM.and e✝ (const? (-43))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n5_thm (e✝ : IntW 8) : sub e✝ (LLVM.and e✝ (const? 42)) ⊑ LLVM.and e✝ (const? (-43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


