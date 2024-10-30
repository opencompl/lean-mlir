
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gnegatedhbitmask_proof
theorem neg_mask1_lshr_thm :
  ∀ (e : IntW 8), sub (const? 0) (LLVM.and (lshr e (const? 3)) (const? 1)) ⊑ ashr (shl e (const? 4)) (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_mask1_lshr_thm :
  ∀ (e : IntW 8),
    sub (const? 10) (LLVM.and (lshr e (const? 1)) (const? 1)) ⊑
      add (ashr (shl e (const? 6)) (const? 7)) (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


