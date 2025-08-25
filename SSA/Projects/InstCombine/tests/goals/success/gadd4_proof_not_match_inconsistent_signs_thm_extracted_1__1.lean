
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_match_inconsistent_signs_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(299#64 = 0 ∨ (299#64 == 0 || 64 != 1 && x == intMin 64 && 299#64 == -1) = true ∨ 64#64 = 0) →
    299#64 = 0 ∨
        (299#64 == 0 || 64 != 1 && x == intMin 64 && 299#64 == -1) = true ∨
          True ∧ (x.sdiv 299#64 &&& 63#64).smulOverflow 299#64 = true ∨
            True ∧ (x.sdiv 299#64 &&& 63#64).umulOverflow 299#64 = true ∨
              True ∧ (x % 299#64).saddOverflow ((x.sdiv 299#64 &&& 63#64) * 299#64) = true ∨
                True ∧ (x % 299#64).uaddOverflow ((x.sdiv 299#64 &&& 63#64) * 299#64) = true →
      False :=
sorry