
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_eq_with_diff_one_logical_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x == 13#8) = 1#1 → 1#1 = ofBool (x + BitVec.ofInt 8 (-13) <ᵤ 2#8) :=
sorry