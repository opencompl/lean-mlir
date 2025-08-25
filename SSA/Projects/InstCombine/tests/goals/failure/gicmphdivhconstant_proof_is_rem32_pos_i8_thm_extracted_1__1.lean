
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem is_rem32_pos_i8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(32#8 == 0 || 8 != 1 && x == intMin 8 && 32#8 == -1) = true →
    ofBool (0#8 <ₛ x.srem 32#8) = ofBool (0#8 <ₛ x &&& BitVec.ofInt 8 (-97)) :=
sorry