
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_icmps_comm3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬x ≥ ↑8 →
    ¬ofBool (x_1 &&& 1#8 != 0#8) = 1#1 →
      ¬(True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨
            x ≥ ↑8 ∨
              True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ ofBool (x_1 &&& (1#8 <<< x ||| 1#8) == 1#8 <<< x ||| 1#8) = 1#1) →
        ofBool (x_1 &&& 1#8 <<< x != 0#8) &&& 0#1 = 0#1 :=
sorry