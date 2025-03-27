
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gcanonicalizehshlhlshrhtohmasking_proof
theorem positive_samevar_thm (e e_1 : IntW 32) : lshr (shl e_1 e) e ⊑ LLVM.and (lshr (const? 32 (-1)) e) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_sameconst_thm (e : IntW 32) : lshr (shl e (const? 32 5)) (const? 32 5) ⊑ LLVM.and e (const? 32 134217727) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_biggerShl_thm (e : IntW 32) :
  lshr (shl e (const? 32 10)) (const? 32 5) ⊑ LLVM.and (shl e (const? 32 5)) (const? 32 134217696) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_biggerLshr_thm (e : IntW 32) :
  lshr (shl e (const? 32 5)) (const? 32 10) ⊑ LLVM.and (lshr e (const? 32 5)) (const? 32 4194303) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_biggerLshr_lshrexact_thm (e : IntW 32) :
  lshr (shl e (const? 32 5)) (const? 32 10) { «exact» := true } ⊑
    LLVM.and (lshr e (const? 32 5) { «exact» := true }) (const? 32 4194303) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_samevar_shlnuw_thm (e e_1 : IntW 32) : lshr (shl e_1 e { «nsw» := false, «nuw» := true }) e ⊑ e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_sameconst_shlnuw_thm (e : IntW 32) :
  lshr (shl e (const? 32 5) { «nsw» := false, «nuw» := true }) (const? 32 5) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_biggerShl_shlnuw_thm (e : IntW 32) :
  lshr (shl e (const? 32 10) { «nsw» := false, «nuw» := true }) (const? 32 5) ⊑
    shl e (const? 32 5) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_biggerLshr_shlnuw_thm (e : IntW 32) :
  lshr (shl e (const? 32 5) { «nsw» := false, «nuw» := true }) (const? 32 10) ⊑ lshr e (const? 32 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem positive_biggerLshr_shlnuw_lshrexact_thm (e : IntW 32) :
  lshr (shl e (const? 32 5) { «nsw» := false, «nuw» := true }) (const? 32 10) { «exact» := true } ⊑
    lshr e (const? 32 5) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
