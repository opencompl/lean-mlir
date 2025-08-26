
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

theorem src_is_notmask_lshr_shl_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x_1 ≥ ↑8 ∨ x_1 ≥ ↑8) →
    ¬(True ∧ ((-1#8) <<< x_1).sshiftRight' x_1 ≠ -1#8 ∨ x_1 ≥ ↑8) →
      ofBool (((-1#8) >>> x_1 <<< x_1 ^^^ -1#8) &&& (x ^^^ 123#8) == x ^^^ 123#8) =
        ofBool ((-1#8) <<< x_1 ≤ᵤ x ^^^ BitVec.ofInt 8 (-124)) :=
sorry