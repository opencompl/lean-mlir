
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test25_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (50#32 ≤ₛ x) = 1#1 → 0#1 = ofBool (x + BitVec.ofInt 32 (-50) <ᵤ 50#32) :=
sorry