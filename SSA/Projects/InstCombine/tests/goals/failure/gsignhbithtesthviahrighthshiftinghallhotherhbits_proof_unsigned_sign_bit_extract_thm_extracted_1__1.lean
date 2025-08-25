
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem unsigned_sign_bit_extract_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ofBool (x >>> 31#32 != 0#32) = ofBool (x <ₛ 0#32) :=
sorry