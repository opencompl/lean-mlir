
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_min_7_8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬ofBool (x <ᵤ BitVec.ofInt 8 (-8)) = 1#1 → BitVec.ofInt 8 (-8) &&& BitVec.ofInt 8 (-8) = x &&& BitVec.ofInt 8 (-8) :=
sorry