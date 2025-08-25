
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrult_03_00_exact_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ x >>> 3#4 <<< 3#4 ≠ x ∨ 3#4 ≥ ↑4) → ofBool (x >>> 3#4 <ᵤ 0#4) = 0#1 :=
sorry