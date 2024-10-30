
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2010h11h23hDistributed_proof
theorem foo_thm : ∀ (e e_1 : IntW 32), sub (mul (add e_1 e) e_1) (mul e_1 e_1) ⊑ mul e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


