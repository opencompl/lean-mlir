
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrugt_02_02_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬2#4 ≥ ↑4 → ofBool (2#4 <ᵤ x >>> 2#4) = ofBool (BitVec.ofInt 4 (-5) <ᵤ x) :=
sorry