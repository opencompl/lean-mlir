
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_select_not_sext_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → 64#64 - signExtend 64 (x_1 ^^^ 1#1) = 65#64 :=
sorry