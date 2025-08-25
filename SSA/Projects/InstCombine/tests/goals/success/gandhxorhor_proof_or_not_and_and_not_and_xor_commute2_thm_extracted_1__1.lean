
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_not_and_and_not_and_xor_commute2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬((x_2 == 0 || 32 != 1 && 42#32 == intMin 32 && x_2 == -1) = true ∨
        (x_2 == 0 || 32 != 1 && 42#32 == intMin 32 && x_2 == -1) = true) →
    ((42#32).sdiv x_2 ||| x_1 &&& x ^^^ -1#32) &&& ((x_1 ^^^ x) &&& (42#32).sdiv x_2 ^^^ -1#32) =
      (x_1 ^^^ x) &&& (42#32).sdiv x_2 ^^^ ((42#32).sdiv x_2 ||| x_1 &&& x ^^^ -1#32) :=
sorry