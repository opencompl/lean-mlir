
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthselect_proof
theorem zext_thm : ∀ (e : IntW 1), select e (const? 1) (const? 0) ⊑ zext 41 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_thm : ∀ (e : IntW 1), select e (const? (-1)) (const? 0) ⊑ sext 41 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_zext_thm : ∀ (e : IntW 1), select e (const? 0) (const? 1) ⊑ zext 999 (LLVM.xor e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_sext_thm : ∀ (e : IntW 1), select e (const? 0) (const? (-1)) ⊑ sext 999 (LLVM.xor e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


