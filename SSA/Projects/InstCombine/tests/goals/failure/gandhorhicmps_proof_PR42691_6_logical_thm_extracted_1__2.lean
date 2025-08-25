
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_6_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x <ᵤ BitVec.ofInt 32 (-2147483647)) = 1#1 →
    ofBool (x == -1#32) = ofBool (x + 1#32 <ᵤ BitVec.ofInt 32 (-2147483646)) :=
sorry