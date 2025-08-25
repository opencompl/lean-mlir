
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t13_x_is_one_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    ofBool (1#32 <<< (32#32 - x_1) &&& truncate 32 (x >>> zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16))) != 0#32) =
      ofBool (x &&& 65536#64 != 0#64) :=
sorry