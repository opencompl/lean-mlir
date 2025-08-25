
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_inverted_icmp_preds_reverse_thm.extracted_1._5 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 <ₛ x_2) = 1#1 → ¬ofBool (x_2 ≤ₛ x_3) = 1#1 → x_1 ||| x = x_1 ||| 0#32 :=
sorry