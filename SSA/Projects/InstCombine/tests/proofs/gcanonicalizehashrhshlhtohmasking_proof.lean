
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gcanonicalizehashrhshlhtohmasking_proof
theorem positive_samevar_thm (e e_1 : IntW 8) :
  shl (ashr e_1 e) e ⊑ LLVM.and (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_sameconst_thm (e : IntW 8) : shl (ashr e (const? 8 3)) (const? 8 3) ⊑ LLVM.and e (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggerashr_thm (e : IntW 8) :
  shl (ashr e (const? 8 6)) (const? 8 3) ⊑ LLVM.and (ashr e (const? 8 3)) (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggershl_thm (e : IntW 8) :
  shl (ashr e (const? 8 3)) (const? 8 6) ⊑ LLVM.and (shl e (const? 8 3)) (const? 8 (-64)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_samevar_shlnuw_thm (e e_1 : IntW 8) :
  shl (ashr e_1 e) e { «nsw» := false, «nuw» := true } ⊑
    LLVM.and (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_sameconst_shlnuw_thm (e : IntW 8) :
  shl (ashr e (const? 8 3)) (const? 8 3) { «nsw» := false, «nuw» := true } ⊑ LLVM.and e (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggerashr_shlnuw_thm (e : IntW 8) :
  shl (ashr e (const? 8 6)) (const? 8 3) { «nsw» := false, «nuw» := true } ⊑
    LLVM.and (ashr e (const? 8 3)) (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggershl_shlnuw_thm (e : IntW 8) :
  shl (ashr e (const? 8 3)) (const? 8 6) { «nsw» := false, «nuw» := true } ⊑
    LLVM.and (shl e (const? 8 3) { «nsw» := false, «nuw» := true }) (const? 8 (-64)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_samevar_shlnsw_thm (e e_1 : IntW 8) :
  shl (ashr e_1 e) e { «nsw» := true, «nuw» := false } ⊑
    LLVM.and (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_sameconst_shlnsw_thm (e : IntW 8) :
  shl (ashr e (const? 8 3)) (const? 8 3) { «nsw» := true, «nuw» := false } ⊑ LLVM.and e (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggerashr_shlnsw_thm (e : IntW 8) :
  shl (ashr e (const? 8 6)) (const? 8 3) { «nsw» := true, «nuw» := false } ⊑
    LLVM.and (ashr e (const? 8 3)) (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggershl_shlnsw_thm (e : IntW 8) :
  shl (ashr e (const? 8 3)) (const? 8 6) { «nsw» := true, «nuw» := false } ⊑
    LLVM.and (shl e (const? 8 3) { «nsw» := true, «nuw» := false }) (const? 8 (-64)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_samevar_shlnuwnsw_thm (e e_1 : IntW 8) :
  shl (ashr e_1 e) e { «nsw» := true, «nuw» := true } ⊑
    LLVM.and (shl (const? 8 (-1)) e { «nsw» := true, «nuw» := false }) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_sameconst_shlnuwnsw_thm (e : IntW 8) :
  shl (ashr e (const? 8 3)) (const? 8 3) { «nsw» := true, «nuw» := true } ⊑ LLVM.and e (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggerashr_shlnuwnsw_thm (e : IntW 8) :
  shl (ashr e (const? 8 6)) (const? 8 3) { «nsw» := true, «nuw» := true } ⊑
    LLVM.and (ashr e (const? 8 3)) (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggershl_shlnuwnsw_thm (e : IntW 8) :
  shl (ashr e (const? 8 3)) (const? 8 6) { «nsw» := true, «nuw» := true } ⊑
    LLVM.and (shl e (const? 8 3) { «nsw» := true, «nuw» := true }) (const? 8 64) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_samevar_ashrexact_thm (e e_1 : IntW 8) : shl (ashr e_1 e { «exact» := true }) e ⊑ e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_sameconst_ashrexact_thm (e : IntW 8) : shl (ashr e (const? 8 3) { «exact» := true }) (const? 8 3) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggerashr_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 6) { «exact» := true }) (const? 8 3) ⊑ ashr e (const? 8 3) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggershl_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 3) { «exact» := true }) (const? 8 6) ⊑ shl e (const? 8 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_samevar_shlnsw_ashrexact_thm (e e_1 : IntW 8) :
  shl (ashr e_1 e { «exact» := true }) e { «nsw» := true, «nuw» := false } ⊑ e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_sameconst_shlnsw_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 3) { «exact» := true }) (const? 8 3) { «nsw» := true, «nuw» := false } ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggerashr_shlnsw_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 6) { «exact» := true }) (const? 8 3) { «nsw» := true, «nuw» := false } ⊑
    ashr e (const? 8 3) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggershl_shlnsw_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 3) { «exact» := true }) (const? 8 6) { «nsw» := true, «nuw» := false } ⊑
    shl e (const? 8 3) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_samevar_shlnuw_ashrexact_thm (e e_1 : IntW 8) :
  shl (ashr e_1 e { «exact» := true }) e { «nsw» := false, «nuw» := true } ⊑ e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_sameconst_shlnuw_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 3) { «exact» := true }) (const? 8 3) { «nsw» := false, «nuw» := true } ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggerashr_shlnuw_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 6) { «exact» := true }) (const? 8 3) { «nsw» := false, «nuw» := true } ⊑
    ashr e (const? 8 3) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggershl_shlnuw_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 3) { «exact» := true }) (const? 8 6) { «nsw» := false, «nuw» := true } ⊑
    shl e (const? 8 3) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_samevar_shlnuwnsw_ashrexact_thm (e e_1 : IntW 8) :
  shl (ashr e_1 e { «exact» := true }) e { «nsw» := true, «nuw» := true } ⊑ e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_sameconst_shlnuwnsw_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 3) { «exact» := true }) (const? 8 3) { «nsw» := true, «nuw» := true } ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggerashr_shlnuwnsw_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 6) { «exact» := true }) (const? 8 3) { «nsw» := true, «nuw» := true } ⊑
    ashr e (const? 8 3) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem positive_biggershl_shlnuwnsw_ashrexact_thm (e : IntW 8) :
  shl (ashr e (const? 8 3) { «exact» := true }) (const? 8 6) { «nsw» := true, «nuw» := true } ⊑
    shl e (const? 8 3) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
