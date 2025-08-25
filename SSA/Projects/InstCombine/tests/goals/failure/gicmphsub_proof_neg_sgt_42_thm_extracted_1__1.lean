
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_sgt_42_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (42#32 <ₛ 0#32 - x) = ofBool (x + -1#32 <ₛ BitVec.ofInt 32 (-43)) :=
sorry