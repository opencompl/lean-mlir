
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

theorem src_is_mask_shl_lshr_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    ¬x ≥ ↑8 →
      ofBool (0#8 != (x_1 ^^^ 123#8) &&& ((-1#8) <<< x >>> x ^^^ -1#8)) = ofBool ((-1#8) >>> x <ᵤ x_1 ^^^ 122#8) :=
sorry