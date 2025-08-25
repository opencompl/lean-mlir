
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem thisdoesnotloop_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ₛ BitVec.ofInt 32 (-128)) = 1#1 → truncate 8 128#32 = BitVec.ofInt 8 (-128) :=
sorry