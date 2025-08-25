
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem set_bits_thm.extracted_1._4 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(True ∧ (x &&& BitVec.ofInt 8 (-6) &&& 0#8 != 0) = true) →
      x &&& BitVec.ofInt 8 (-6) = x &&& BitVec.ofInt 8 (-6) ||| 0#8 :=
sorry