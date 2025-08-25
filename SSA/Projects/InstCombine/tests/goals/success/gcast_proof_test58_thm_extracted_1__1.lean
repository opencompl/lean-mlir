
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test58_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 → 8#32 ≥ ↑32 ∨ True ∧ (truncate 32 x >>> 8#32 ||| 128#32).msb = true → False :=
sorry