
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_ne_opposite_msb_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool (BitVec.ofInt 8 (-128) >>> x != 1#8) = ofBool (x != 7#8) :=
sorry