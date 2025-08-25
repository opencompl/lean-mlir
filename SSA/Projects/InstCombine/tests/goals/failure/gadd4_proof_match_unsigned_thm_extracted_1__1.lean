
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem match_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(299#64 = 0 ∨ 299#64 = 0 ∨ 64#64 = 0) →
    19136#64 = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x % 299#64 + x / 299#64 % 64#64 * 299#64)) PoisonOr.poison :=
sorry