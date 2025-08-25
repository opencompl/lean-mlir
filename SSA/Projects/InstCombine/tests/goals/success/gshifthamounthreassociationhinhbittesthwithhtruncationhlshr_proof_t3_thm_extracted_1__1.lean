
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(32#32 - x ≥ ↑32 ∨ zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    ofBool (x_1 <<< (32#32 - x) &&& truncate 32 (131071#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16))) != 0#32) =
      ofBool (x_1 &&& 1#32 != 0#32) :=
sorry