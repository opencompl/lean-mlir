
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem absdiff_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ofBool (x_1 <ᵤ x) = 1#1 →
    (signExtend 64 (ofBool (x_1 <ᵤ x)) ^^^ x_1 - x) - signExtend 64 (ofBool (x_1 <ᵤ x)) = 0#64 - (x_1 - x) :=
sorry