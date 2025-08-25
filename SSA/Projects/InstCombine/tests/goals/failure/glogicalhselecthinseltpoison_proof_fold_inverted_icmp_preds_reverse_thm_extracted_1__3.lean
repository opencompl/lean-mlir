
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_inverted_icmp_preds_reverse_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 <ₛ x_1) = 1#1 → ofBool (x_1 ≤ₛ x_2) = 1#1 → 0#32 ||| 0#32 = 0#32 ||| x :=
sorry