
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 → 1#32 ≥ ↑32 ∨ True ∧ (x >>> 1#32).uaddOverflow 2147483647#32 = true → False :=
sorry