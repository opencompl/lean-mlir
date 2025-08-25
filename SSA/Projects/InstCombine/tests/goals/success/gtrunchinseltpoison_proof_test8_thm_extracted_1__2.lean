
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test8_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬32#128 ≥ ↑128 →
    ¬(True ∧ zeroExtend 64 x_1 <<< 32#64 >>> 32#64 ≠ zeroExtend 64 x_1 ∨
          32#64 ≥ ↑64 ∨ True ∧ (zeroExtend 64 x_1 <<< 32#64 &&& zeroExtend 64 x != 0) = true) →
      truncate 64 (zeroExtend 128 x_1 <<< 32#128 ||| zeroExtend 128 x) =
        zeroExtend 64 x_1 <<< 32#64 ||| zeroExtend 64 x :=
sorry