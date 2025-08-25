
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_umin_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (15#32 <ᵤ x) = 1#1 → 15#32 &&& BitVec.ofInt 32 (-32) = 0#32 :=
sorry