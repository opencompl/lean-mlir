
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gaddnegneg_proof
theorem l_thm :
  ∀ (e e_1 e_2 : IntW 32), add (add (sub (const? 0) e_2) (sub (const? 0) e_1)) e ⊑ sub e (add e_2 e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


