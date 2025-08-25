
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test9_thm.extracted_1._2 : ∀ (x : BitVec 77),
  ¬(True ∧ (x &&& 562949953421310#77 &&& 1#77 != 0) = true) →
    (x &&& 562949953421310#77) + 1#77 = x &&& 562949953421310#77 ||| 1#77 :=
sorry