
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test5_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(zeroExtend 32 x ≥ ↑32 ∨ 32#32 <<< zeroExtend 32 x = 0) →
    True ∧ x.msb = true ∨ True ∧ 32#32 <<< zeroExtend 32 x >>> zeroExtend 32 x ≠ 32#32 ∨ zeroExtend 32 x ≥ ↑32 →
      False :=
sorry