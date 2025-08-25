
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_mask_const_thm.extracted_1._3 : ∀ (x : BitVec 16),
  ¬(True ∧ (1000#32).ssubOverflow (signExtend 32 x) = true ∨
        15#16 ≥ ↑16 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 15#16)) = true) →
    ¬ofBool (x <ₛ 0#16) = 1#1 → 1000#32 - signExtend 32 x &&& 0#32 - zeroExtend 32 (x >>> 15#16) = 0#32 :=
sorry