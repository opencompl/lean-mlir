
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

theorem lshr_32_add_known_32_leading_zeroes_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬32#64 ≥ ↑64 →
    True ∧ (x_1 &&& 4294967295#64).saddOverflow (x &&& 4294967295#64) = true ∨
        True ∧ (x_1 &&& 4294967295#64).uaddOverflow (x &&& 4294967295#64) = true ∨ 32#64 ≥ ↑64 →
      False :=
sorry