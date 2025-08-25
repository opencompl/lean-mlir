
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test17_thm.extracted_1._1 : ∀ (x : BitVec 32), ¬x = 0 → 1#32 % x = zeroExtend 32 (ofBool (x != 1#32)) :=
sorry