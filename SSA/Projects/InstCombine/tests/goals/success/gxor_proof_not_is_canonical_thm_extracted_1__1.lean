
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_is_canonical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 → ((x_1 ^^^ 1073741823#32) + x) <<< 2#32 = (x + (x_1 ^^^ -1#32)) <<< 2#32 :=
sorry