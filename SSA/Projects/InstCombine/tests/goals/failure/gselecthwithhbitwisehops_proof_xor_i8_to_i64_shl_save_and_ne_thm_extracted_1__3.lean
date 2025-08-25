
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_i8_to_i64_shl_save_and_ne_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 8),
  ¬ofBool (x_1 &&& 1#8 != 0#8) = 1#1 →
    63#64 ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value x) PoisonOr.poison :=
sorry