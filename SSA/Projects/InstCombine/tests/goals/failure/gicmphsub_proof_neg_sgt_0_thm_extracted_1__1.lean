
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_sgt_0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (0#8 <ₛ 0#8 - x) = ofBool (BitVec.ofInt 8 (-128) <ᵤ x) :=
sorry