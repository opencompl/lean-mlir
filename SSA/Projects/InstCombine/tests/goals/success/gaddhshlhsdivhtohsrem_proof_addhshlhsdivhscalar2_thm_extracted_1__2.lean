
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem addhshlhsdivhscalar2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((BitVec.ofInt 32 (-1073741824) == 0 || 32 != 1 && x == intMin 32 && BitVec.ofInt 32 (-1073741824) == -1) = true ∨
        30#32 ≥ ↑32) →
    ¬(1073741824#32 == 0 || 32 != 1 && x == intMin 32 && 1073741824#32 == -1) = true →
      x.sdiv (BitVec.ofInt 32 (-1073741824)) <<< 30#32 + x = x.srem 1073741824#32 :=
sorry