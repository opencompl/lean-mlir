
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_sext_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 →
    ¬(x_1 ≥ ↑8 ∨ True ∧ (31#8 >>> x_1).msb = true) →
      ofBool ((signExtend 16 (31#8 >>> x_1) ^^^ -1#16) &&& (x ^^^ 123#16) == 0#16) =
        ofBool (x ^^^ 123#16 ≤ᵤ zeroExtend 16 (31#8 >>> x_1)) :=
sorry