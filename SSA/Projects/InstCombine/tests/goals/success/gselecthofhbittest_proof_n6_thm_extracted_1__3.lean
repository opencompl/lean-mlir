
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n6_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 != 0#32) = 1#1 → ¬ofBool (x &&& 1#32 == 0#32) = 1#1 → ¬2#32 ≥ ↑32 → 1#32 = x >>> 2#32 &&& 1#32 :=
sorry