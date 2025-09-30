
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

theorem test_sub__all_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 255#32 == 6#32) = 1#1 →
    ¬(True ∧ (BitVec.ofInt 32 (-254)).ssubOverflow (x &&& 255#32) = true ∨
          True ∧ (BitVec.ofInt 32 (-254)).usubOverflow (x &&& 255#32) = true) →
      BitVec.ofInt 32 (-260) = BitVec.ofInt 32 (-254) - (x &&& 255#32) :=
sorry