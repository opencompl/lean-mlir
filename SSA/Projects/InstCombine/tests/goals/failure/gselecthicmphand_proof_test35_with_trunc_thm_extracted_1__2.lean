
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test35_with_trunc_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬ofBool (0#32 ≤ₛ truncate 32 x) = 1#1 → ofBool (x &&& 2147483648#64 == 0#64) = 1#1 → 100#32 = 60#32 :=
sorry