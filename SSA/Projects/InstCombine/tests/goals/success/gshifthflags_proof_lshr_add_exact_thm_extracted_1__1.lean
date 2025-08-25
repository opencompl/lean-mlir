
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_add_exact_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x &&& 2#8 ≥ ↑8 →
    True ∧ (x_1 &&& BitVec.ofInt 8 (-4)) >>> (x &&& 2#8) <<< (x &&& 2#8) ≠ x_1 &&& BitVec.ofInt 8 (-4) ∨
        x &&& 2#8 ≥ ↑8 →
      False :=
sorry