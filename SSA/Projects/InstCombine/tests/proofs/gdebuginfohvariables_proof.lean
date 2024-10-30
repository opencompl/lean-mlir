
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gdebuginfohvariables_proof
theorem test_sext_zext_thm : ∀ (e : IntW 16), sext 64 (zext 32 e) ⊑ zext 64 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_cast_select_thm : ∀ (e : IntW 1), zext 32 (select e (const? 3) (const? 5)) ⊑ select e (const? 3) (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


