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

theorem mul_selectp2_x_propegate_nuw_thm.extracted_1._4 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(True ∧ (4#8).smulOverflow x = true ∨ True ∧ (4#8).umulOverflow x = true) →
      ¬(True ∧ x <<< 2#8 >>> 2#8 ≠ x ∨ 2#8 ≥ ↑8) → 4#8 * x = x <<< 2#8 :=
sorry