
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gfoldhsubhofhnothtohinchofhadd_proof
theorem p0_scalar_thm (e e_1 : IntW 32) : sub e_1 (LLVM.xor e (const? 32 (-1))) ⊑ add (add e (const? 32 1)) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


