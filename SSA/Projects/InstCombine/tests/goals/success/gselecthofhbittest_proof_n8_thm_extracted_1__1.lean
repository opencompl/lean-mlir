
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n8_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1#32 == 1#32) = 1#1 → ¬2#32 ≥ ↑32 → ofBool (x &&& 1#32 == 0#32) = 1#1 → x >>> 2#32 &&& 1#32 = 1#32 :=
sorry