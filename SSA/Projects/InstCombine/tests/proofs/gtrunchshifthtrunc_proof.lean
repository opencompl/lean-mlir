
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gtrunchshifthtrunc_proof
theorem trunc_lshr_trunc_thm : ∀ (e : IntW 64), trunc 8 (lshr (trunc 32 e) (const? 8)) ⊑ trunc 8 (lshr e (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_ashr_trunc_thm : ∀ (e : IntW 64), trunc 8 (ashr (trunc 32 e) (const? 8)) ⊑ trunc 8 (lshr e (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem trunc_ashr_trunc_exact_thm : ∀ (e : IntW 64), trunc 8 (ashr (trunc 32 e) (const? 8)) ⊑ trunc 8 (lshr e (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


