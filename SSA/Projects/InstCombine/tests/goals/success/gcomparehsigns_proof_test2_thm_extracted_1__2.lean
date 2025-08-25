
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬3#32 ≥ ↑32 → zeroExtend 32 (ofBool (x_1 &&& 8#32 == x &&& 8#32)) = (x_1 ^^^ x) >>> 3#32 &&& 1#32 ^^^ 1#32 :=
sorry