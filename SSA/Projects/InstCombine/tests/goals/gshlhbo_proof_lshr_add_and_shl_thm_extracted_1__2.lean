
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

theorem lshr_add_and_shl_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(5#32 ≥ ↑32 ∨ 5#32 ≥ ↑32) →
    ¬5#32 ≥ ↑32 → (x_1 + (x >>> 5#32 &&& 127#32)) <<< 5#32 = (x &&& 4064#32) + x_1 <<< 5#32 :=
sorry