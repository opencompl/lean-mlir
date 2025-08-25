
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_ashr_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
  ¬x_1 = 1#1 →
    ¬x ≥ ↑8 →
      ofBool ((x_2 ^^^ 123#8) &&& (15#8).sshiftRight' x <ᵤ x_2 ^^^ 123#8) =
        ofBool ((15#8).sshiftRight' x <ᵤ x_2 ^^^ 123#8) :=
sorry