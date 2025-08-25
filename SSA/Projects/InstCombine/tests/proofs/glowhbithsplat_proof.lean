
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section glowhbithsplat_proof
theorem t0_thm (e : IntW 8) :
  ashr (shl e (const? 8 7)) (const? 8 7) ⊑
    sub (const? 8 0) (LLVM.and e (const? 8 1)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t1_otherbitwidth_thm (e : IntW 16) :
  ashr (shl e (const? 16 15)) (const? 16 15) ⊑
    sub (const? 16 0) (LLVM.and e (const? 16 1)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem n11_thm (e : IntW 8) :
  ashr (shl e (const? 8 7)) (const? 8 6) ⊑ ashr (shl e (const? 8 7)) (const? 8 6) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem n12_thm (e : IntW 8) :
  ashr (shl e (const? 8 6)) (const? 8 6) ⊑ ashr (shl e (const? 8 6)) (const? 8 6) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
