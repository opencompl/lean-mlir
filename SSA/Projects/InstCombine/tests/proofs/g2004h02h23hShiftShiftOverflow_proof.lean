
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2004h02h23hShiftShiftOverflow_proof
theorem test_thm : ∀ (e : IntW 32), ashr (ashr e (const? 17)) (const? 17) ⊑ ashr e (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm : ∀ (e : IntW 32), shl (shl e (const? 17)) (const? 17) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


