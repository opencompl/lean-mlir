
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrult_02_03_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬2#4 ≥ ↑4 → ofBool (x >>> 2#4 <ᵤ 3#4) = ofBool (x <ᵤ BitVec.ofInt 4 (-4)) :=
sorry