
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_ne_0_and_4096_or_32_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (0#32 != x_1 &&& 4096#32) = 1#1 →
    7#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x ||| 32#32)) PoisonOr.poison :=
sorry