
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gavghlsb_proof
theorem avg_lsb_thm (e e_1 : IntW 8) :
  lshr (add (LLVM.and e_1 (const? 8 1)) (LLVM.and e (const? 8 1)) { «nsw» := true, «nuw» := true }) (const? 8 1) ⊑
    LLVM.and e_1 (LLVM.and e (const? 8 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
