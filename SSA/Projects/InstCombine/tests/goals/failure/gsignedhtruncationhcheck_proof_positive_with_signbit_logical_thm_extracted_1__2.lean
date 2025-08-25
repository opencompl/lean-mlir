
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_with_signbit_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (-1#32 <ₛ x) = 1#1 → 0#1 = ofBool (x <ᵤ 128#32) :=
sorry