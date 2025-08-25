
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section g2008h07h09hSubAndError_proof
theorem foo_thm (e : IntW 32) :
  LLVM.and (sub (const? 32 5) e) (const? 32 2) ⊑ LLVM.and (sub (const? 32 1) e) (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
