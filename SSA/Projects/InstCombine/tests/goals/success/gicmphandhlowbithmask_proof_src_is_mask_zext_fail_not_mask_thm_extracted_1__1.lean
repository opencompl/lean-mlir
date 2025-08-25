
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_zext_fail_not_mask_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  ¬x ≥ ↑8 →
    ofBool ((x_1 ^^^ 123#16) &&& zeroExtend 16 (BitVec.ofInt 8 (-2) >>> x) == x_1 ^^^ 123#16) =
      ofBool (x_1 ^^^ BitVec.ofInt 16 (-124) ||| zeroExtend 16 (BitVec.ofInt 8 (-2) >>> x) == -1#16) :=
sorry