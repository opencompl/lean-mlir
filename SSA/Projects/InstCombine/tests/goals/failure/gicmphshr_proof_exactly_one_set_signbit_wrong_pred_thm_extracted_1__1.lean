
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem exactly_one_set_signbit_wrong_pred_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (zeroExtend 8 (ofBool (-1#8 <ₛ x)) <ₛ x_1 >>> 7#8) = ofBool (x &&& x_1 <ₛ 0#8) :=
sorry