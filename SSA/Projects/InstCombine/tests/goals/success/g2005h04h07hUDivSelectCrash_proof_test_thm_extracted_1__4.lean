
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._4 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬x = 1#1 → ¬1#32 = 0 → ¬0#32 ≥ ↑32 → x_1 / 1#32 = x_1 >>> 0#32 :=
sorry