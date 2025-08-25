
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem absdiff2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬ofBool (x_1 <ᵤ x) = 1#1 →
    (x_1 - x ^^^ signExtend 64 (ofBool (x_1 <ᵤ x))) - signExtend 64 (ofBool (x_1 <ᵤ x)) = x_1 - x :=
sorry