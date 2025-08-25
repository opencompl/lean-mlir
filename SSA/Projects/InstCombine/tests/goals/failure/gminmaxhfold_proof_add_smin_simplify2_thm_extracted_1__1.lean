
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_smin_simplify2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.saddOverflow (BitVec.ofInt 32 (-3)) = true) →
    ¬ofBool (x + BitVec.ofInt 32 (-3) <ₛ 2147483645#32) = 1#1 → 2147483645#32 = x + BitVec.ofInt 32 (-3) :=
sorry