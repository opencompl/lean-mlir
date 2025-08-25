
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_or_thm.extracted_1._8 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ¬x_2 ^^^ 1#1 = 1#1 → ofBool (x_1 <ᵤ x) ^^^ 1#1 = 0#1 :=
sorry