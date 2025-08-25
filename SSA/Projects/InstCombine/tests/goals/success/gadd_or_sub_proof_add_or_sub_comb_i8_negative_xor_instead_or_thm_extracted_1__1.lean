
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_or_sub_comb_i8_negative_xor_instead_or_thm.extracted_1._1 : ∀ (x : BitVec 8),
  (0#8 - x ^^^ x) + x = (x ^^^ 0#8 - x) + x :=
sorry