
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gannotations_proof
theorem do_not_add_annotation_to_existing_instr_thm (e✝ e✝¹ : IntW 32) : add (const? 0) (add e✝¹ e✝) ⊑ add e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


