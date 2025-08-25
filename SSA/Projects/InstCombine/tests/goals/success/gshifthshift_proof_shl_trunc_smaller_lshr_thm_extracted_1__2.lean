
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_trunc_smaller_lshr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ 5#8 ≥ ↑8) →
    ¬2#8 ≥ ↑8 → truncate 8 (x >>> 3#32) <<< 5#8 = truncate 8 x <<< 2#8 &&& BitVec.ofInt 8 (-32) :=
sorry