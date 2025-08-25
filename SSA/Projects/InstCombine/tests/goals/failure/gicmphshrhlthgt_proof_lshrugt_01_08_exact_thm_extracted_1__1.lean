
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrugt_01_08_exact_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ x >>> 1#4 <<< 1#4 ≠ x ∨ 1#4 ≥ ↑4) → ofBool (BitVec.ofInt 4 (-8) <ᵤ x >>> 1#4) = 0#1 :=
sorry