
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrult_01_14_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (x >>> 1#4 <ᵤ BitVec.ofInt 4 (-2)) = 1#1 :=
sorry