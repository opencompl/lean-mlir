
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_irregular_bit_widths_thm.extracted_1._2 : ∀ (x x_1 : BitVec 31),
  ¬(13#31 ≥ ↑31 ∨ 13#31 ≥ ↑31 ∨ 7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31) →
    ¬(7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31) →
      ofBool (truncate 5 (x_1 >>> 13#31) != truncate 5 (x >>> 13#31)) |||
          ofBool (truncate 6 (x_1 >>> 7#31) != truncate 6 (x >>> 7#31)) =
        ofBool (truncate 11 (x_1 >>> 7#31) != truncate 11 (x >>> 7#31)) :=
sorry