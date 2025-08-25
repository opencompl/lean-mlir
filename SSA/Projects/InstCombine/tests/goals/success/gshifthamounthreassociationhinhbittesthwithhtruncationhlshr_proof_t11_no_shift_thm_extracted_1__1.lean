
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t11_no_shift_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(64#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-64)) ≥ ↑64) →
    ofBool (x_2 <<< (64#32 - x_1) &&& truncate 32 (x >>> zeroExtend 64 (x_1 + BitVec.ofInt 32 (-64))) != 0#32) =
      ofBool (x &&& zeroExtend 64 x_2 != 0#64) :=
sorry