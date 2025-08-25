
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n11_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (30#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-31) ≥ ↑16) →
    True ∧ (30#16 - x).msb = true ∨ zeroExtend 32 (30#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-31) ≥ ↑16 → False :=
sorry