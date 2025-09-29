
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

theorem n2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 →
    ¬(True ∧ ((-1#8) <<< x_1).sshiftRight' x_1 ≠ -1#8 ∨ x_1 ≥ ↑8) →
      ofBool (((-1#8) <<< x_1 ^^^ 1#8) &&& x != x) = ofBool (x &&& ((-1#8) <<< x_1 ^^^ BitVec.ofInt 8 (-2)) != 0#8) :=
sorry