
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehashrhshlhtohmasking_proof
theorem positive_samevar_thm : ∀ (e e_1 : IntW 8), shl (ashr e_1 e) e ⊑ LLVM.and (shl (const? (-1)) e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_sameconst_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 3) ⊑ LLVM.and e (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerashr_thm :
  ∀ (e : IntW 8), shl (ashr e (const? 6)) (const? 3) ⊑ LLVM.and (ashr e (const? 3)) (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggershl_thm :
  ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 6) ⊑ LLVM.and (shl e (const? 3)) (const? (-64)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_samevar_shlnuw_thm : ∀ (e e_1 : IntW 8), shl (ashr e_1 e) e ⊑ LLVM.and (shl (const? (-1)) e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_sameconst_shlnuw_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 3) ⊑ LLVM.and e (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerashr_shlnuw_thm :
  ∀ (e : IntW 8), shl (ashr e (const? 6)) (const? 3) ⊑ LLVM.and (ashr e (const? 3)) (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggershl_shlnuw_thm :
  ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 6) ⊑ LLVM.and (shl e (const? 3)) (const? (-64)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_samevar_shlnsw_thm : ∀ (e e_1 : IntW 8), shl (ashr e_1 e) e ⊑ LLVM.and (shl (const? (-1)) e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_sameconst_shlnsw_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 3) ⊑ LLVM.and e (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerashr_shlnsw_thm :
  ∀ (e : IntW 8), shl (ashr e (const? 6)) (const? 3) ⊑ LLVM.and (ashr e (const? 3)) (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggershl_shlnsw_thm :
  ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 6) ⊑ LLVM.and (shl e (const? 3)) (const? (-64)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_samevar_shlnuwnsw_thm : ∀ (e e_1 : IntW 8), shl (ashr e_1 e) e ⊑ LLVM.and (shl (const? (-1)) e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_sameconst_shlnuwnsw_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 3) ⊑ LLVM.and e (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerashr_shlnuwnsw_thm :
  ∀ (e : IntW 8), shl (ashr e (const? 6)) (const? 3) ⊑ LLVM.and (ashr e (const? 3)) (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggershl_shlnuwnsw_thm :
  ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 6) ⊑ LLVM.and (shl e (const? 3)) (const? 64) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_samevar_ashrexact_thm : ∀ (e e_1 : IntW 8), shl (ashr e_1 e) e ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_sameconst_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 3) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerashr_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 6)) (const? 3) ⊑ ashr e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggershl_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 6) ⊑ shl e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_samevar_shlnsw_ashrexact_thm : ∀ (e e_1 : IntW 8), shl (ashr e_1 e) e ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_sameconst_shlnsw_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 3) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerashr_shlnsw_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 6)) (const? 3) ⊑ ashr e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggershl_shlnsw_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 6) ⊑ shl e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_samevar_shlnuw_ashrexact_thm : ∀ (e e_1 : IntW 8), shl (ashr e_1 e) e ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_sameconst_shlnuw_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 3) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerashr_shlnuw_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 6)) (const? 3) ⊑ ashr e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggershl_shlnuw_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 6) ⊑ shl e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_samevar_shlnuwnsw_ashrexact_thm : ∀ (e e_1 : IntW 8), shl (ashr e_1 e) e ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_sameconst_shlnuwnsw_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 3) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggerashr_shlnuwnsw_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 6)) (const? 3) ⊑ ashr e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_biggershl_shlnuwnsw_ashrexact_thm : ∀ (e : IntW 8), shl (ashr e (const? 3)) (const? 6) ⊑ shl e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


