
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_pow2_ult_smin_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool (BitVec.ofInt 8 (-128) >>> x <ᵤ BitVec.ofInt 8 (-128)) = ofBool (x != 0#8) :=
sorry