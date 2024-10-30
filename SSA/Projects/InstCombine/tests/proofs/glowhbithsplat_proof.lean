
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section glowhbithsplat_proof
theorem t0_thm :
  ∀ (e : IntW 8),
    ashr (shl e (const? 7)) (const? 7) ⊑
      sub (const? 0) (LLVM.and e (const? 1)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_otherbitwidth_thm :
  ∀ (e : IntW 16),
    ashr (shl e (const? 15)) (const? 15) ⊑
      sub (const? 0) (LLVM.and e (const? 1)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


