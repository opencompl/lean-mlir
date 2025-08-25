
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_neg_slt_zero_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool (BitVec.ofInt 8 (-17) >>> x <ₛ 0#8) = ofBool (x == 0#8) :=
sorry