
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_mask_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ x_1.ssubOverflow (signExtend 32 x) = true ∨
        15#16 ≥ ↑16 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 15#16)) = true) →
    ofBool (x <ₛ 0#16) = 1#1 →
      ¬(True ∧ x_1.ssubOverflow (signExtend 32 x) = true) →
        x_1 - signExtend 32 x &&& 0#32 - zeroExtend 32 (x >>> 15#16) = x_1 - signExtend 32 x :=
sorry