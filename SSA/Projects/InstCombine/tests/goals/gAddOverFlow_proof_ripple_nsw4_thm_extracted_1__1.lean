
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

theorem ripple_nsw4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  True ∧ (x_1 &&& 21843#16).saddOverflow (x &&& BitVec.ofInt 16 (-21845)) = true ∨
      True ∧ (x_1 &&& 21843#16).uaddOverflow (x &&& BitVec.ofInt 16 (-21845)) = true →
    False :=
sorry