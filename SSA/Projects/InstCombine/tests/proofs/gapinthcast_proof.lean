
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gapinthcast_proof
theorem test1_thm (e : IntW 17) :
  trunc 17 (LLVM.or (lshr (zext 37 e) (const? 37 8)) (shl (zext 37 e) (const? 37 8))) ⊑
    LLVM.or (lshr e (const? 17 8)) (shl e (const? 17 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 167) :
  trunc 167 (LLVM.or (lshr (zext 577 e) (const? 577 9)) (shl (zext 577 e) (const? 577 8))) ⊑
    LLVM.or (lshr e (const? 167 9)) (shl e (const? 167 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
