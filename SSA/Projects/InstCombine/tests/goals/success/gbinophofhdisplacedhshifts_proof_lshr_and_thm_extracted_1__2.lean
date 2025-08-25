
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_and_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x + 1#8 ≥ ↑8) → ¬x ≥ ↑8 → 48#8 >>> x &&& 64#8 >>> (x + 1#8) = 32#8 >>> x :=
sorry