
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gJavaCompare_proof
theorem le_thm (e e_1 : IntW 32) :
  icmp IntPredicate.sle
      (select (icmp IntPredicate.slt e_1 e) (const? 32 (-1))
        (select (icmp IntPredicate.sgt e_1 e) (const? 32 1) (const? 32 0)))
      (const? 32 0) ⊑
    icmp IntPredicate.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
