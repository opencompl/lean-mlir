
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_slt_42_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ofBool (0#128 - x <ₛ 42#128) = ofBool (BitVec.ofInt 128 (-43) <ₛ x + -1#128) :=
sorry