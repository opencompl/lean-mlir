
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test36_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ofBool (truncate 8 (x >>> 31#32) == 0#8) = ofBool (-1#32 <ₛ x) :=
sorry