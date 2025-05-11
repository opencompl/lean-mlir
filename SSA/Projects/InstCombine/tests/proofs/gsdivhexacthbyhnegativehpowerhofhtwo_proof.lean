
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsdivhexacthbyhnegativehpowerhofhtwo_proof
theorem t0_thm (e : IntW 8) :
  LLVM.sdiv e (const? 8 (-32)) { «exact» := true } ⊑
    sub (const? 8 0) (ashr e (const? 8 5) { «exact» := true }) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem prove_exact_with_high_mask_thm (e : IntW 8) :
  LLVM.sdiv (LLVM.and e (const? 8 (-32))) (const? 8 (-4)) ⊑
    sub (const? 8 0) (LLVM.and (ashr e (const? 8 2)) (const? 8 (-8))) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem prove_exact_with_high_mask_limit_thm (e : IntW 8) :
  LLVM.sdiv (LLVM.and e (const? 8 (-32))) (const? 8 (-32)) ⊑
    sub (const? 8 0) (ashr e (const? 8 5)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
