
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative_and_odd_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true ∨ 31#32 ≥ ↑32) →
    ¬31#32 ≥ ↑32 → x.srem 2#32 >>> 31#32 = x >>> 31#32 &&& x :=
sorry