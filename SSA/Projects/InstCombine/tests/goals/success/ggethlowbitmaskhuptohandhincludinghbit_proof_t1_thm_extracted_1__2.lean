
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ x ≥ ↑16) → ¬15#16 - x ≥ ↑16 → 1#16 <<< x + -1#16 ||| 1#16 <<< x = (-1#16) >>> (15#16 - x) :=
sorry