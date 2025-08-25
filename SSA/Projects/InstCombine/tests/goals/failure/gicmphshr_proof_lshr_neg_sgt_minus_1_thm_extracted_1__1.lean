
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_neg_sgt_minus_1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool (-1#8 <ₛ BitVec.ofInt 8 (-17) >>> x) = ofBool (x != 0#8) :=
sorry