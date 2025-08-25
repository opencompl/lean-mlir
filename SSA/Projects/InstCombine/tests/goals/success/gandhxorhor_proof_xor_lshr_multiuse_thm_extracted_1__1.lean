
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_lshr_multiuse_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 8),
  ¬(x_2 ≥ ↑8 ∨
        x_2 ≥ ↑8 ∨
          x_2 ≥ ↑8 ∨
            (x_3 >>> x_2 ^^^ x_1 ^^^ x >>> x_2 == 0 ||
                8 != 1 && x_3 >>> x_2 ^^^ x_1 == intMin 8 && x_3 >>> x_2 ^^^ x_1 ^^^ x >>> x_2 == -1) =
              true) →
    x_2 ≥ ↑8 ∨
        x_2 ≥ ↑8 ∨
          ((x_3 ^^^ x) >>> x_2 ^^^ x_1 == 0 ||
              8 != 1 && x_3 >>> x_2 ^^^ x_1 == intMin 8 && (x_3 ^^^ x) >>> x_2 ^^^ x_1 == -1) =
            true →
      False :=
sorry