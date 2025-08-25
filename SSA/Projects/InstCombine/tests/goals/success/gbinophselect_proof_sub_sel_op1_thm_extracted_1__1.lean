
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_sel_op1_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → ¬(True ∧ (42#32).ssubOverflow 42#32 = true) → 42#32 - 42#32 = zeroExtend 32 (x ^^^ 1#1) :=
sorry