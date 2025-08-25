
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test37_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ofBool (truncate 8 (x >>> 31#32 ||| 512#32) == 11#8) = 0#1 :=
sorry