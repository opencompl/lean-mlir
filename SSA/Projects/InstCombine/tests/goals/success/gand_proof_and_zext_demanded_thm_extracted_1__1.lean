
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_zext_demanded_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬8#16 ≥ ↑16 → 8#16 ≥ ↑16 ∨ True ∧ (x >>> 8#16).msb = true → False :=
sorry