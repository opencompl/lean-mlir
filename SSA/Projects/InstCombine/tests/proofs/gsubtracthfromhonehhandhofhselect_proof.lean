
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubtracthfromhonehhandhofhselect_proof
theorem t0_sub_from_trueval_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  sub e_2 (select e_1 e_2 e) ⊑ select e_1 (const? 8 0) (sub e_2 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem t1_sub_from_falseval_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  sub e_2 (select e_1 e e_2) ⊑ select e_1 (sub e_2 e) (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


