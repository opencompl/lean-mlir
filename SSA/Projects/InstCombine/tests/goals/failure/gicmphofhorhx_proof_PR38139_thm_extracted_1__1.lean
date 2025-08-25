
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR38139_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x ||| BitVec.ofInt 8 (-64) != x) = ofBool (x <ᵤ BitVec.ofInt 8 (-64)) :=
sorry