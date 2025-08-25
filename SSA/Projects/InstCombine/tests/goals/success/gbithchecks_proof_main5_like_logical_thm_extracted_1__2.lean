
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main5_like_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 7#32) = 1#1 → ofBool (x &&& 7#32 != 7#32) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
sorry