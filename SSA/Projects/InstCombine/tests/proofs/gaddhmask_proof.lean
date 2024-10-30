
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gaddhmask_proof
theorem add_mask_ashr28_i32_thm :
  ∀ (e : IntW 32),
    add (LLVM.and (ashr e (const? 28)) (const? 8)) (ashr e (const? 28)) ⊑
      LLVM.and (lshr e (const? 28)) (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


