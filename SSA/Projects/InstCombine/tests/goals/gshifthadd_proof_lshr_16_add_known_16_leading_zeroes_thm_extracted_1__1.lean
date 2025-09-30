
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

theorem lshr_16_add_known_16_leading_zeroes_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬16#32 ≥ ↑32 →
    True ∧ (x_1 &&& 65535#32).saddOverflow (x &&& 65535#32) = true ∨
        True ∧ (x_1 &&& 65535#32).uaddOverflow (x &&& 65535#32) = true ∨ 16#32 ≥ ↑32 →
      False :=
sorry