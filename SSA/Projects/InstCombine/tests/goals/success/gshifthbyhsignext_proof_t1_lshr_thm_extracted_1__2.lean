
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬signExtend 32 x ≥ ↑32 →
    ¬(True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32) → x_1 >>> signExtend 32 x = x_1 >>> zeroExtend 32 x :=
sorry