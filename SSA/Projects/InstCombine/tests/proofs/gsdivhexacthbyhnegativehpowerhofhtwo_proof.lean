
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsdivhexacthbyhnegativehpowerhofhtwo_proof
theorem t0_thm (e : IntW 8) :
  LLVM.sdiv e (const? (-32)) ⊑ sub (const? 0) (ashr e (const? 5)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem prove_exact_with_high_mask_thm (e : IntW 8) :
  LLVM.sdiv (LLVM.and e (const? (-32))) (const? (-4)) ⊑
    sub (const? 0) (LLVM.and (ashr e (const? 2)) (const? (-8))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem prove_exact_with_high_mask_limit_thm (e : IntW 8) :
  LLVM.sdiv (LLVM.and e (const? (-32))) (const? (-32)) ⊑
    sub (const? 0) (ashr e (const? 5)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


