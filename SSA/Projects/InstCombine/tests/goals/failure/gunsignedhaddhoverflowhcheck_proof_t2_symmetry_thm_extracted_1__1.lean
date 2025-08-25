
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t2_symmetry_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8), ofBool (x_1 + x <ᵤ x_1) = ofBool (x_1 ^^^ -1#8 <ᵤ x) :=
sorry