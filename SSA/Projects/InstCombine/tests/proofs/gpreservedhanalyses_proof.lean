
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gpreservedhanalyses_proof
theorem test_thm (e : IntW 32) : add (add e (const? 32 5)) (const? 32 (-5)) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


