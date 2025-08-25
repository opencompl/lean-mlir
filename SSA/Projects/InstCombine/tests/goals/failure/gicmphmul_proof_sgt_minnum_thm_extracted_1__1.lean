
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_minnum_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow 7#8 = true) → ofBool (BitVec.ofInt 8 (-128) <ₛ x * 7#8) = 1#1 :=
sorry