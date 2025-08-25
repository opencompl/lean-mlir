
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_select_not_zext_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → 64#64 - zeroExtend 64 (x_1 ^^^ 1#1) = 63#64 :=
sorry