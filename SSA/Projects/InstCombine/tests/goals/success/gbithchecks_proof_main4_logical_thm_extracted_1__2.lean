
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main4_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 7#32) = 1#1 →
    ¬ofBool (x &&& 48#32 == 48#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 55#32)) :=
sorry