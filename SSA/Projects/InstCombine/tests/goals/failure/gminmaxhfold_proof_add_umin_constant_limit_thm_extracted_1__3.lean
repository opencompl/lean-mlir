
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_umin_constant_limit_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 41#32 = true) →
    ¬ofBool (x + 41#32 <ᵤ 42#32) = 1#1 → ofBool (x == 0#32) = 1#1 → 42#32 = 41#32 :=
sorry