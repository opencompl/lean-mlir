
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test10_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬16#32 ≥ ↑32 →
    16#32 ≥ ↑32 ∨ True ∧ (x >>> 16#32).umulOverflow 65535#32 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 64 (x >>> 16#32) * 65535#64)) PoisonOr.poison :=
sorry