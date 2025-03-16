
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gearly_constfold_changes_IR_proof
theorem foo_thm (e : IntW 32) : LLVM.and e (LLVM.or (const? 32 0) (const? 32 7)) ⊑ LLVM.and e (const? 32 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
