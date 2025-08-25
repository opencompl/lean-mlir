
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_nsw_poison_constant_fold_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬(True ∧ (65#8).saddOverflow 64#8 = true) → 65#8 + 64#8 = BitVec.ofInt 8 (-127) :=
sorry