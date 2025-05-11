
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gbinophofhdisplacedhshifts_proof
theorem shl_or_thm (e : IntW 8) :
  LLVM.or (shl (const? 8 16) e) (shl (const? 8 3) (add e (const? 8 1))) ⊑ shl (const? 8 22) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_or_thm (e : IntW 8) :
  LLVM.or (lshr (const? 8 16) e) (lshr (const? 8 3) (add e (const? 8 1))) ⊑ lshr (const? 8 17) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_or_thm (e : IntW 8) :
  LLVM.or (ashr (const? 8 (-64)) e) (ashr (const? 8 (-128)) (add e (const? 8 1))) ⊑ ashr (const? 8 (-64)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_xor_thm (e : IntW 8) :
  LLVM.xor (shl (const? 8 16) e) (shl (const? 8 3) (add e (const? 8 1))) ⊑ shl (const? 8 22) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_xor_thm (e : IntW 8) :
  LLVM.xor (lshr (const? 8 16) e) (lshr (const? 8 3) (add e (const? 8 1))) ⊑ lshr (const? 8 17) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_xor_thm (e : IntW 8) :
  LLVM.xor (ashr (const? 8 (-128)) e) (ashr (const? 8 (-64)) (add e (const? 8 1))) ⊑ lshr (const? 8 96) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_and_thm (e : IntW 8) :
  LLVM.and (shl (const? 8 48) e) (shl (const? 8 8) (add e (const? 8 1))) ⊑ shl (const? 8 16) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_and_thm (e : IntW 8) :
  LLVM.and (lshr (const? 8 48) e) (lshr (const? 8 64) (add e (const? 8 1))) ⊑ lshr (const? 8 32) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_and_thm (e : IntW 8) :
  LLVM.and (ashr (const? 8 (-64)) e) (ashr (const? 8 (-128)) (add e (const? 8 1))) ⊑ ashr (const? 8 (-64)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_add_thm (e : IntW 8) :
  add (shl (const? 8 16) e) (shl (const? 8 7) (add e (const? 8 1))) ⊑ shl (const? 8 30) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_add_fail_thm (e : IntW 8) :
  add (lshr (const? 8 16) e) (lshr (const? 8 7) (add e (const? 8 1))) ⊑
    add (lshr (const? 8 16) e) (lshr (const? 8 7) (add e (const? 8 1))) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_add_fail_thm (e : IntW 8) :
  add (ashr (const? 8 (-128)) e) (ashr (const? 8 (-128)) (add e (const? 8 1))) ⊑
    add (ashr (const? 8 (-128)) e { «exact» := true })
      (ashr (const? 8 (-128)) (add e (const? 8 1)) { «exact» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_or_commuted_thm (e : IntW 8) :
  LLVM.or (shl (const? 8 3) (add e (const? 8 1))) (shl (const? 8 16) e) ⊑ shl (const? 8 22) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mismatched_shifts_thm (e : IntW 8) :
  LLVM.or (shl (const? 8 16) e) (lshr (const? 8 3) (add e (const? 8 1))) ⊑
    LLVM.or (shl (const? 8 16) e) (lshr (const? 8 3) (add e (const? 8 1))) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_or_with_or_disjoint_instead_of_add_thm (e : IntW 8) :
  LLVM.or (shl (const? 8 16) e) (shl (const? 8 3) (LLVM.or e (const? 8 1) { «disjoint» := true })) ⊑
    shl (const? 8 22) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
