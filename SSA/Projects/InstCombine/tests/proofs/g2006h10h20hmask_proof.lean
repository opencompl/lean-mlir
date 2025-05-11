
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section g2006h10h20hmask_proof
theorem foo_thm (e e_1 : IntW 64) :
  zext 64 (LLVM.and (trunc 32 e_1) (trunc 32 e)) ⊑ LLVM.and (LLVM.and e_1 e) (const? 64 4294967295) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
