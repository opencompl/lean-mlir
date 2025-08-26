
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsubtracthfromhonehhandhofhselect_proof
theorem t0_sub_from_trueval_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  sub e_2 (select e_1 e_2 e) ⊑ select e_1 (const? 8 0) (sub e_2 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t1_sub_from_falseval_thm (e : IntW 8) (e_1 : IntW 1) (e_2 : IntW 8) :
  sub e_2 (select e_1 e e_2) ⊑ select e_1 (sub e_2 e) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
