
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem mul130_low_thm.extracted_1._1 : ∀ (x x_1 : BitVec 130),
  ¬(65#130 ≥ ↑130 ∨ 65#130 ≥ ↑130 ∨ 65#130 ≥ ↑130) →
    (x_1 >>> 65#130 * (x &&& 36893488147419103231#130) + (x_1 &&& 36893488147419103231#130) * x >>> 65#130) <<< 65#130 +
        (x_1 &&& 36893488147419103231#130) * (x &&& 36893488147419103231#130) =
      x * x_1 :=
sorry