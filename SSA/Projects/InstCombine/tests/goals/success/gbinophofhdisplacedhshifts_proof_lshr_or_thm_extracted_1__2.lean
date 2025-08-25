
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_or_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x + 1#8 ≥ ↑8) → ¬x ≥ ↑8 → 16#8 >>> x ||| 3#8 >>> (x + 1#8) = 17#8 >>> x :=
sorry