
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem unsigned_sign_bit_extract_with_trunc_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → ofBool (truncate 32 (x >>> 63#64) != 0#32) = ofBool (x <ₛ 0#64) :=
sorry