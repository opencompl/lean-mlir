
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_trunc_base_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (-1#16 <ₛ truncate 16 x) = 1#1 → 0#1 = ofBool (x &&& 65408#32 == 0#32) :=
sorry