
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_ranges_signed_pred_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (x + 127#64 <ₛ 1024#64) &&& ofBool (x + 128#64 <ₛ 256#64) =
    ofBool (x + BitVec.ofInt 64 (-9223372036854775681) <ᵤ BitVec.ofInt 64 (-9223372036854775553)) :=
sorry