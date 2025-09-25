
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

theorem src_x_and_nmask_eq_thm.extracted_1._5 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  x_2 = 1#1 →
    ¬x_1 ≥ ↑8 →
      ¬x_2 ^^^ 1#1 = 1#1 →
        ¬(True ∧ ((-1#8) <<< x_1).sshiftRight' x_1 ≠ -1#8 ∨ x_1 ≥ ↑8) →
          ofBool ((-1#8) <<< x_1 == x &&& (-1#8) <<< x_1) = ofBool ((-1#8) <<< x_1 ≤ᵤ x) :=
sorry