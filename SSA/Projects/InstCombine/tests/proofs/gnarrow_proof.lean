
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gnarrow_proof
theorem shrink_xor_thm : ∀ (e : IntW 64), trunc 32 (LLVM.xor e (const? 1)) ⊑ LLVM.xor (trunc 32 e) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shrink_or_thm : ∀ (e : IntW 6), trunc 3 (LLVM.or e (const? (-31))) ⊑ LLVM.or (trunc 3 e) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


