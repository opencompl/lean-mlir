
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_or_sub_comb_i64_commuted4_thm.extracted_1._1 : ∀ (x : BitVec 64),
  x * x + (x * x ||| 0#64 - x * x) = x * x + -1#64 &&& x * x :=
sorry