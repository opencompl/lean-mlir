
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gunsignedhaddhoverflowhcheckhviahxor_proof
theorem t3_no_extrause_thm (e e_1 : IntW 8) :
  icmp IntPred.ult (LLVM.xor e_1 (const? 8 (-1))) e ⊑
    icmp IntPred.ugt e (LLVM.xor e_1 (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
