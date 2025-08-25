
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test85_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow (BitVec.ofInt 32 (-16777216)) = true ∨
        True ∧ (x + BitVec.ofInt 32 (-16777216)) >>> 23#32 <<< 23#32 ≠ x + BitVec.ofInt 32 (-16777216) ∨ 23#32 ≥ ↑32) →
    23#32 ≥ ↑32 → False :=
sorry