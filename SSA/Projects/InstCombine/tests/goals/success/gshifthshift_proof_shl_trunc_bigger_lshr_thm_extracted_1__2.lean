
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_trunc_bigger_lshr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(5#32 ≥ ↑32 ∨ 3#8 ≥ ↑8) →
    ¬2#32 ≥ ↑32 → truncate 8 (x >>> 5#32) <<< 3#8 = truncate 8 (x >>> 2#32) &&& BitVec.ofInt 8 (-8) :=
sorry