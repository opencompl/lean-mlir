
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem tryFactorization_xor_lshr_lshr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(x ≥ ↑32 ∨ x ≥ ↑32) → ¬x ≥ ↑32 → BitVec.ofInt 32 (-3) >>> x ^^^ 5#32 >>> x = BitVec.ofInt 32 (-8) >>> x :=
sorry