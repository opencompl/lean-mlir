
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_notmask_lshr_shl_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x_1 ≥ ↑8 ∨ x_1 ≥ ↑8) →
    ¬(True ∧ ((-1#8) <<< x_1).sshiftRight' x_1 ≠ -1#8 ∨ x_1 ≥ ↑8) →
      ofBool (((-1#8) >>> x_1 <<< x_1 ^^^ -1#8) &&& (x ^^^ 123#8) == x ^^^ 123#8) =
        ofBool ((-1#8) <<< x_1 ≤ᵤ x ^^^ BitVec.ofInt 8 (-124)) :=
sorry