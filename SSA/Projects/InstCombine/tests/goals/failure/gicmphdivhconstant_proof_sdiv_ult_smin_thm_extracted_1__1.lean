
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv_ult_smin_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(x == 0 || 8 != 1 && x_1 == intMin 8 && x == -1) = true →
    ofBool (x_1.sdiv x <ᵤ BitVec.ofInt 8 (-128)) = ofBool (-1#8 <ₛ x_1.sdiv x) :=
sorry