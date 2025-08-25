
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n15_wrong_comparison_predicate_and_constant_thm.extracted_1._3 : ∀ (x : BitVec 8),
  ¬ofBool (x &&& 15#8 <ᵤ 2#8) = 1#1 →
    ¬ofBool (x &&& 14#8 == 0#8) = 1#1 → x + 16#8 &&& BitVec.ofInt 8 (-16) = (x &&& BitVec.ofInt 8 (-16)) + 16#8 :=
sorry