
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem modulo32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(32#32 == 0 || 32 != 1 && x == intMin 32 && 32#32 == -1) = true →
    ofBool (x.srem 32#32 <ₛ 0#32) = 1#1 →
      ¬((32#32 == 0 || 32 != 1 && x == intMin 32 && 32#32 == -1) = true ∨
            True ∧ (32#32).saddOverflow (x.srem 32#32) = true) →
        32#32 + x.srem 32#32 = x &&& 31#32 :=
sorry