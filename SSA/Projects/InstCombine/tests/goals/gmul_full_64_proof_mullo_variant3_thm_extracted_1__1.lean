
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem mullo_variant3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬(32#64 ≥ ↑64 ∨
        True ∧ (x_1 >>> 32#64).umulOverflow (x &&& 4294967295#64) = true ∨
          32#64 ≥ ↑64 ∨
            True ∧ (x_1 &&& 4294967295#64).umulOverflow (x >>> 32#64) = true ∨
              32#64 ≥ ↑64 ∨ True ∧ (x_1 &&& 4294967295#64).umulOverflow (x &&& 4294967295#64) = true) →
    (x_1 >>> 32#64 * (x &&& 4294967295#64) + (x_1 &&& 4294967295#64) * x >>> 32#64) <<< 32#64 +
        (x_1 &&& 4294967295#64) * (x &&& 4294967295#64) =
      x * x_1 :=
sorry