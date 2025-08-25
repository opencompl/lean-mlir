
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem differentconsts_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x + 16#32 <ᵤ 144#32) = 1#1 → ofBool (x <ₛ 128#32) = 1#1 → ofBool (127#32 <ₛ x) = 1#1 → 256#16 = -1#16 :=
sorry