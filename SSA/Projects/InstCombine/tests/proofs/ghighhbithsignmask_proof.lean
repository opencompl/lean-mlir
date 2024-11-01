
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section ghighhbithsignmask_proof
theorem t0_thm (e✝ : IntW 64) : sub (const? 0) (lshr e✝ (const? 63)) ⊑ ashr e✝ (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t0_exact_thm (e✝ : IntW 64) : sub (const? 0) (lshr e✝ (const? 63)) ⊑ ashr e✝ (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_thm (e✝ : IntW 64) : sub (const? 0) (ashr e✝ (const? 63)) ⊑ lshr e✝ (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t3_exact_thm (e✝ : IntW 64) : sub (const? 0) (ashr e✝ (const? 63)) ⊑ lshr e✝ (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n9_thm (e✝ : IntW 64) :
  sub (const? 0) (lshr e✝ (const? 62)) ⊑ sub (const? 0) (lshr e✝ (const? 62)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


