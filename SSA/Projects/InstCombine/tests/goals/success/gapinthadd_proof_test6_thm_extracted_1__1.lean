
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test6_thm.extracted_1._1 : ∀ (x : BitVec 65),
  ¬(64#65 ≥ ↑65 ∨ 64#65 ≥ ↑65) → (x ^^^ 1#65 <<< 64#65) + 1#65 <<< 64#65 = x :=
sorry