
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section ghighhbithsignmaskhwithhtrunc_proof
theorem t0_thm :
  ∀ (e : IntW 64), sub (const? 0) (trunc 32 (lshr e (const? 63))) ⊑ trunc 32 (ashr e (const? 63)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_exact_thm :
  ∀ (e : IntW 64), sub (const? 0) (trunc 32 (lshr e (const? 63))) ⊑ trunc 32 (ashr e (const? 63)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_thm :
  ∀ (e : IntW 64), sub (const? 0) (trunc 32 (ashr e (const? 63))) ⊑ trunc 32 (lshr e (const? 63)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t3_exact_thm :
  ∀ (e : IntW 64), sub (const? 0) (trunc 32 (ashr e (const? 63))) ⊑ trunc 32 (lshr e (const? 63)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n9_thm :
  ∀ (e : IntW 64),
    sub (const? 0) (trunc 32 (lshr e (const? 62))) ⊑
      sub (const? 0) (trunc 32 (lshr e (const? 62))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n10_thm :
  ∀ (e : IntW 64),
    sub (const? 1) (trunc 32 (lshr e (const? 63))) ⊑
      add (trunc 32 (ashr e (const? 63))) (const? 1) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


