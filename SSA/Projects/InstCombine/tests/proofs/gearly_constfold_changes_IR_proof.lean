
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gearly_constfold_changes_IR_proof
theorem foo_thm : ∀ (e : IntW 32), LLVM.and e (LLVM.or (const? 0) (const? 7)) ⊑ LLVM.and e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


