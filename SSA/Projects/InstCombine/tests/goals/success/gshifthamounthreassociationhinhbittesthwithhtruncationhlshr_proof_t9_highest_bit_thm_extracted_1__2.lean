
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t9_highest_bit_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(64#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + -1#32) ≥ ↑64) →
    ¬63#64 ≥ ↑64 →
      ofBool (x_2 <<< (64#32 - x_1) &&& truncate 32 (x >>> zeroExtend 64 (x_1 + -1#32)) != 0#32) =
        ofBool (x >>> 63#64 &&& zeroExtend 64 x_2 != 0#64) :=
sorry