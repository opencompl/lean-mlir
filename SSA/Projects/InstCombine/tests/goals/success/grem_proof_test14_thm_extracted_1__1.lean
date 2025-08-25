
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test14_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (1#32 <<< x) = 0) →
    True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 ∨ True ∧ (zeroExtend 64 (1#32 <<< x)).saddOverflow (-1#64) = true →
      False :=
sorry