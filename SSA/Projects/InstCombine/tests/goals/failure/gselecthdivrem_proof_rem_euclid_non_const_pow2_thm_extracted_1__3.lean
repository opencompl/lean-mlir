
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem rem_euclid_non_const_pow2_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ (1#8 <<< x == 0 || 8 != 1 && x_1 == intMin 8 && 1#8 <<< x == -1) = true) →
    ¬ofBool (x_1.srem (1#8 <<< x) <ₛ 0#8) = 1#1 → True ∧ ((-1#8) <<< x).sshiftRight' x ≠ -1#8 ∨ x ≥ ↑8 → False :=
sorry