
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthimmhcanon_proof
theorem thisdoesnotloop_thm (e e_1 : IntW 32) :
  trunc 8 (select (icmp IntPredicate.slt e_1 (const? 32 (-128))) (const? 32 128) e) ⊑
    select (icmp IntPredicate.slt e_1 (const? 32 (-128))) (const? 8 (-128)) (trunc 8 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


