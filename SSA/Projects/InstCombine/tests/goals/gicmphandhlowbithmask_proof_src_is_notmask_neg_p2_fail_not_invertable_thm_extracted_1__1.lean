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

theorem src_is_notmask_neg_p2_fail_not_invertable_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (0#8 == 0#8 - (0#8 - x_1 &&& x_1) &&& (x ^^^ 123#8)) =
    ofBool (x_1 ||| 0#8 - x_1 ≤ᵤ x ^^^ BitVec.ofInt 8 (-124)) :=
sorry