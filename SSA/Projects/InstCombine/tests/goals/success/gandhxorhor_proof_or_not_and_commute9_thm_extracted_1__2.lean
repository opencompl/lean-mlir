
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_not_and_commute9_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬((x_2 == 0 || 32 != 1 && 42#32 == intMin 32 && x_2 == -1) = true ∨
        (x_1 == 0 || 32 != 1 && 42#32 == intMin 32 && x_1 == -1) = true ∨
          (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
            (x_1 == 0 || 32 != 1 && 42#32 == intMin 32 && x_1 == -1) = true ∨
              (x_2 == 0 || 32 != 1 && 42#32 == intMin 32 && x_2 == -1) = true ∨
                (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true) →
    ¬((x_1 == 0 || 32 != 1 && 42#32 == intMin 32 && x_1 == -1) = true ∨
          (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
            (x_2 == 0 || 32 != 1 && 42#32 == intMin 32 && x_2 == -1) = true) →
      (((42#32).sdiv x_2 ||| (42#32).sdiv x_1) ^^^ -1#32) &&& (42#32).sdiv x |||
          (42#32).sdiv x_1 &&& (((42#32).sdiv x_2 ||| (42#32).sdiv x) ^^^ -1#32) =
        ((42#32).sdiv x_1 ^^^ (42#32).sdiv x) &&& ((42#32).sdiv x_2 ^^^ -1#32) :=
sorry