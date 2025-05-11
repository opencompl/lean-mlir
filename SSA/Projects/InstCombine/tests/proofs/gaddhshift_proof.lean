
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gaddhshift_proof
theorem flip_add_of_shift_neg_thm (e e_1 e_2 : IntW 8) :
  add (shl (sub (const? 8 0) e_2) e_1 { «nsw» := true, «nuw» := true }) e ⊑ sub e (shl e_2 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
