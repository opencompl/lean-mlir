
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_signbit_shl_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬8#32 ≥ ↑32 → (x + BitVec.ofInt 32 (-65536)) <<< 8#32 = x <<< 8#32 + BitVec.ofInt 32 (-16777216) :=
sorry