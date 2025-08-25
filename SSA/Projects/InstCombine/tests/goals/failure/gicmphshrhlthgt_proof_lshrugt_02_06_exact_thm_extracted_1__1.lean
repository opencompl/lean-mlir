
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrugt_02_06_exact_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ x >>> 2#4 <<< 2#4 ≠ x ∨ 2#4 ≥ ↑4) → ofBool (6#4 <ᵤ x >>> 2#4) = 0#1 :=
sorry