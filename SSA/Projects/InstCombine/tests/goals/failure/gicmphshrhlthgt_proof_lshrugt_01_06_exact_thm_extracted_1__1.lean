
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrugt_01_06_exact_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ x >>> 1#4 <<< 1#4 ≠ x ∨ 1#4 ≥ ↑4) → ofBool (6#4 <ᵤ x >>> 1#4) = ofBool (x == BitVec.ofInt 4 (-2)) :=
sorry