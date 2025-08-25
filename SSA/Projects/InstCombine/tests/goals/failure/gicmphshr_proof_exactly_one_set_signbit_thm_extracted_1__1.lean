
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem exactly_one_set_signbit_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (x_1 >>> 7#8 == zeroExtend 8 (ofBool (-1#8 <ₛ x))) = ofBool (x_1 ^^^ x <ₛ 0#8) :=
sorry