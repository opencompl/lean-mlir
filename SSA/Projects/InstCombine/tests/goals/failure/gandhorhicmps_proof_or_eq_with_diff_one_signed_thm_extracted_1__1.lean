
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_eq_with_diff_one_signed_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 0#32) ||| ofBool (x == -1#32) = ofBool (x + 1#32 <ᵤ 2#32) :=
sorry