
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section glowhbithsplat_proof
theorem t0_thm (e : IntW 8) :
  ashr (shl e (const? 8 7)) (const? 8 7) ⊑
    sub (const? 8 0) (LLVM.and e (const? 8 1)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_otherbitwidth_thm (e : IntW 16) :
  ashr (shl e (const? 16 15)) (const? 16 15) ⊑
    sub (const? 16 0) (LLVM.and e (const? 16 1)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


