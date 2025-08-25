
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_constant_equal_with_the_top_bit_of_demandedbits_pass_thm.extracted_1._1 : ∀ (x : BitVec 32),
  x + 16#32 &&& 24#32 = x &&& 24#32 ^^^ 16#32 :=
sorry