
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

theorem bitwise_and_bitwise_and_icmps_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬x ≥ ↑8 →
    ¬(True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8) →
      ofBool (x_2 == 42#8) &&& ofBool (x_1 &&& 1#8 != 0#8) &&& ofBool (x_1 &&& 1#8 <<< x != 0#8) =
        ofBool (x_2 == 42#8) &&& ofBool (x_1 &&& (1#8 <<< x ||| 1#8) == 1#8 <<< x ||| 1#8) :=
sorry