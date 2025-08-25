
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem addhshlhsdivhscalar0_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬((BitVec.ofInt 8 (-4) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-4) == -1) = true ∨ 2#8 ≥ ↑8) →
    ¬(4#8 == 0 || 8 != 1 && x == intMin 8 && 4#8 == -1) = true →
      x.sdiv (BitVec.ofInt 8 (-4)) <<< 2#8 + x = x.srem 4#8 :=
sorry