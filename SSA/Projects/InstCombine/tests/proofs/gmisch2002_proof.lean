
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmisch2002_proof
theorem missed_const_prop_2002h12h05_thm :
  ∀ (e : IntW 32), add (sub (const? 0) e) (add e (add (sub (const? 0) (const? 1)) (const? 1))) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


