
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehshlhlshrhtohmasking_proof
theorem positive_samevar_thm : ∀ (e e_1 : IntW 32), lshr (shl e_1 e) e ⊑ LLVM.and (lshr (const? (-1)) e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_sameconst_thm : ∀ (e : IntW 32), lshr (shl e (const? 5)) (const? 5) ⊑ LLVM.and e (const? 134217727) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerShl_thm :
  ∀ (e : IntW 32), lshr (shl e (const? 10)) (const? 5) ⊑ LLVM.and (shl e (const? 5)) (const? 134217696) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerLshr_thm :
  ∀ (e : IntW 32), lshr (shl e (const? 5)) (const? 10) ⊑ LLVM.and (lshr e (const? 5)) (const? 4194303) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerLshr_lshrexact_thm :
  ∀ (e : IntW 32), lshr (shl e (const? 5)) (const? 10) ⊑ LLVM.and (lshr e (const? 5)) (const? 4194303) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_samevar_shlnuw_thm : ∀ (e e_1 : IntW 32), lshr (shl e_1 e { «nsw» := false, «nuw» := true }) e ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_sameconst_shlnuw_thm : ∀ (e : IntW 32), lshr (shl e (const? 5) { «nsw» := false, «nuw» := true }) (const? 5) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerShl_shlnuw_thm :
  ∀ (e : IntW 32),
    lshr (shl e (const? 10) { «nsw» := false, «nuw» := true }) (const? 5) ⊑
      shl e (const? 5) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerLshr_shlnuw_thm :
  ∀ (e : IntW 32), lshr (shl e (const? 5) { «nsw» := false, «nuw» := true }) (const? 10) ⊑ lshr e (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerLshr_shlnuw_lshrexact_thm :
  ∀ (e : IntW 32), lshr (shl e (const? 5) { «nsw» := false, «nuw» := true }) (const? 10) ⊑ lshr e (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


