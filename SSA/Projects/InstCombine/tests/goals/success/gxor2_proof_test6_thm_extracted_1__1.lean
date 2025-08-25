
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test6_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬16#32 ≥ ↑32 → (x ^^^ 1234#32) >>> 16#32 + (x ^^^ 1234#32) = x >>> 16#32 + (x ^^^ 1234#32) :=
sorry