
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n9_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬62#64 ≥ ↑64 → 62#64 ≥ ↑64 ∨ True ∧ (0#64).ssubOverflow (x >>> 62#64) = true → False :=
sorry