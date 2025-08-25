
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_and_fail_mixed_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(x_1 ≥ ↑8 ∨ x ≥ ↑8) →
    ofBool (x_2 ^^^ 123#8 == (x_2 ^^^ 123#8) &&& ((BitVec.ofInt 8 (-8)).sshiftRight' x_1 &&& (-1#8) >>> x)) =
      ofBool ((BitVec.ofInt 8 (-8)).sshiftRight' x_1 &&& (-1#8) >>> x ||| x_2 ^^^ BitVec.ofInt 8 (-124) == -1#8) :=
sorry