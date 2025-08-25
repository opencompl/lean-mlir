
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sel_larger_zext_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 →
    True ∧ (x &&& 65535#32).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 64 (truncate 16 x))) PoisonOr.poison :=
sorry