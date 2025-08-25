
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_umax_muchless_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 12#32) = 1#1 → 12#32 &&& BitVec.ofInt 32 (-32) = x &&& BitVec.ofInt 32 (-32) :=
sorry