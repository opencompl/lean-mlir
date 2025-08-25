
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬3#32 ≥ ↑32 →
    True ∧ (zeroExtend 32 x).saddOverflow 7#32 = true ∨ True ∧ (zeroExtend 32 x).uaddOverflow 7#32 = true ∨ 3#32 ≥ ↑32 →
      False :=
sorry