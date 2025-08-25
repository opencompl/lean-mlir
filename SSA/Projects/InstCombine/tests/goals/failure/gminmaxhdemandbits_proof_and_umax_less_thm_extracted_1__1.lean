
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_umax_less_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 31#32) = 1#1 → 31#32 &&& BitVec.ofInt 32 (-32) = x &&& BitVec.ofInt 32 (-32) :=
sorry