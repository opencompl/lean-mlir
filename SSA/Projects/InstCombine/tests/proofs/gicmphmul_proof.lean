
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphmul_proof
theorem mul_of_pow2s_thm :
  ∀ (e e_1 : IntW 32),
    LLVM.or (mul (LLVM.and e_1 (const? 8)) (LLVM.and e (const? 16))) (const? 128) ⊑ const? 128 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


