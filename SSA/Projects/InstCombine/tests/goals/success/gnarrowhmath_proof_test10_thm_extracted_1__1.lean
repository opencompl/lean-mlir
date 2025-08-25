
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test10_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬16#32 ≥ ↑32 → 16#32 ≥ ↑32 ∨ True ∧ (x >>> 16#32).umulOverflow 65535#32 = true → False :=
sorry