
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_xor_fail_notmask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool ((x_1 ^^^ 123#8) &&& (x ^^^ x + -1#8 ^^^ -1#8) != x_1 ^^^ 123#8) =
    ofBool (x ^^^ 0#8 - x ||| x_1 ^^^ BitVec.ofInt 8 (-124) != -1#8) :=
sorry