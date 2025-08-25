
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_xor_xor_normal_variant3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  x_1 ^^^ x_1 &&& x ||| x ^^^ x_1 &&& x = x_1 ^^^ x :=
sorry