
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem addhshlhsdivhscalar1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬((BitVec.ofInt 8 (-64) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-64) == -1) = true ∨ 6#8 ≥ ↑8) →
    (64#8 == 0 || 8 != 1 && x == intMin 8 && 64#8 == -1) = true → False :=
sorry