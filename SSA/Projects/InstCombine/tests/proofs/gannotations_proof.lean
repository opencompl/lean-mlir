
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gannotations_proof
theorem do_not_add_annotation_to_existing_instr_thm (e e_1 : IntW 32) : add (const? 32 0) (add e_1 e) ⊑ add e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


