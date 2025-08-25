
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_ne_not_pow2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬ofBool (x &&& 5#8 != 0#8) = 1#1 → ¬ofBool (x &&& 5#8 == 0#8) = 1#1 → x = x ^^^ 5#8 :=
sorry