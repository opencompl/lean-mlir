
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrugt_01_06_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (6#4 <ᵤ x >>> 1#4) = ofBool (BitVec.ofInt 4 (-3) <ᵤ x) :=
sorry