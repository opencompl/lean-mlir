
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_lshr_and_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1#32 == 0#32) = 1#1 → ¬1#32 ≥ ↑32 → x >>> 1#32 &&& 1#32 = zeroExtend 32 (ofBool (x &&& 3#32 != 0#32)) :=
sorry