
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrult_01_07_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (x >>> 1#4 <ᵤ 7#4) = ofBool (x <ᵤ BitVec.ofInt 4 (-2)) :=
sorry