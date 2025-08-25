
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

theorem mul16_low_miss_shift_amount_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(8#16 ≥ ↑16 ∨ 8#16 ≥ ↑16 ∨ 8#16 ≥ ↑16) →
    8#16 ≥ ↑16 ∨
        True ∧ (x_1 >>> 8#16).smulOverflow (x &&& 127#16) = true ∨
          True ∧ (x_1 >>> 8#16).umulOverflow (x &&& 127#16) = true ∨
            8#16 ≥ ↑16 ∨
              True ∧ (x_1 &&& 127#16).smulOverflow (x >>> 8#16) = true ∨
                True ∧ (x_1 &&& 127#16).umulOverflow (x >>> 8#16) = true ∨
                  True ∧ (x_1 >>> 8#16 * (x &&& 127#16)).uaddOverflow ((x_1 &&& 127#16) * x >>> 8#16) = true ∨
                    8#16 ≥ ↑16 ∨
                      True ∧ (x_1 &&& 127#16).smulOverflow (x &&& 127#16) = true ∨
                        True ∧ (x_1 &&& 127#16).umulOverflow (x &&& 127#16) = true →
      False :=
sorry