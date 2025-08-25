
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test23_thm.extracted_1._1 : ∀ (x : BitVec 32), ofBool (1#32 <ₛ x) &&& ofBool (x ≤ₛ 2#32) = ofBool (x == 2#32) :=
sorry