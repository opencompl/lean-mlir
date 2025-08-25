
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrugt_01_05_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (5#4 <ᵤ x >>> 1#4) = ofBool (BitVec.ofInt 4 (-5) <ᵤ x) :=
sorry