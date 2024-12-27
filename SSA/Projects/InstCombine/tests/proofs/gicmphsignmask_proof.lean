
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gicmphsignmask_proof
theorem cmp_x_and_negp2_with_eq_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and e (const? 8 (-2))) (const? 8 (-128)) ⊑
    icmp IntPredicate.slt e (const? 8 (-126)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


