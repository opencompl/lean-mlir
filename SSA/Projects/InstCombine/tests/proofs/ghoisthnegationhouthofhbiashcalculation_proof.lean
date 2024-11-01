
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section ghoisthnegationhouthofhbiashcalculation_proof
theorem t0_thm (e e_1 : IntW 8) :
  sub (LLVM.and (sub (const? 0) e_1) e) e ⊑ sub (const? 0) (LLVM.and e (add e_1 (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n7_thm (e e_1 : IntW 8) :
  sub e_1 (LLVM.and (sub (const? 0) e) e_1) ⊑ LLVM.and e_1 (add e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


