
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem modulo2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true →
    ¬ofBool (x.srem 2#32 <ₛ 0#32) = 1#1 →
      ¬((2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true ∨
            True ∧ (0#32).saddOverflow (x.srem 2#32) = true) →
        0#32 + x.srem 2#32 = x &&& 1#32 :=
sorry