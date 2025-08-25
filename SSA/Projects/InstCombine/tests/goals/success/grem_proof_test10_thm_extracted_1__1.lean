
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test10_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#64 = 0 → truncate 32 (signExtend 64 (zeroExtend 32 x * 4#32) % 4#64) = 0#32 :=
sorry