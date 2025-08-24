
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gaddhmaskhneg_proof
theorem dec_mask_neg_i32_thm (e : IntW 32) :
  add (LLVM.and (sub (const? 32 0) e) e) (const? 32 (-1)) ⊑
    LLVM.and (add e (const? 32 (-1))) (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem dec_mask_commute_neg_i32_thm (e : IntW 32) :
  add (LLVM.and (LLVM.sdiv (const? 32 42) e) (sub (const? 32 0) (LLVM.sdiv (const? 32 42) e))) (const? 32 (-1)) ⊑
    LLVM.and (add (LLVM.sdiv (const? 32 42) e) (const? 32 (-1)) { «nsw» := true, «nuw» := false })
      (LLVM.xor (LLVM.sdiv (const? 32 42) e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem dec_commute_mask_neg_i32_thm (e : IntW 32) :
  add (const? 32 (-1)) (LLVM.and (sub (const? 32 0) e) e) ⊑
    LLVM.and (add e (const? 32 (-1))) (LLVM.xor e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
