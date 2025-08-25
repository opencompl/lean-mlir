
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_andn_commute2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 33),
  ¬x_1 = 0 → 42#33 / x_1 &&& (x ^^^ -1#33) ^^^ x = x ||| 42#33 / x_1 :=
sorry