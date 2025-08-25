
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_slt_1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (0#8 - x <ₛ 1#8) = ofBool (x <ᵤ BitVec.ofInt 8 (-127)) :=
sorry