
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bswap_and_mask_1_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(40#64 ≥ ↑64 ∨ 56#64 ≥ ↑64) →
    40#64 ≥ ↑64 ∨ 56#64 ≥ ↑64 ∨ True ∧ (x >>> 40#64 &&& 65280#64 &&& x >>> 56#64 != 0) = true → False :=
sorry