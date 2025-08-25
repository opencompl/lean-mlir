
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR51351_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(zeroExtend 64 x_1 ≥ ↑64 ∨ zeroExtend 64 x_1 ≥ ↑64 ∨ x_1 + BitVec.ofInt 32 (-33) ≥ ↑32) →
    x_1 + BitVec.ofInt 32 (-33) ≥ ↑32 → False :=
sorry